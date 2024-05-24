package carashop.controller.frontend;

import java.io.IOException;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import carashop.controller.BaseController;
import carashop.dto.Cart;
import carashop.dto.Customer;
import carashop.dto.EnumStatus;
import carashop.dto.ProductCart;
import carashop.model.Product;
import carashop.model.ProductComment;
import carashop.model.SaleOrder;
import carashop.model.SaleOrderProduct;
import carashop.model.User;
import carashop.service.ProductCommentService;
import carashop.service.ProductService;
import carashop.service.SaleOrderService;
import carashop.service.VNPayService;

@Controller
public class CheckoutController extends BaseController {

	@Autowired
	private ProductService productService;

	@Autowired
	private SaleOrderService saleOrderService;
	
	@Autowired
	private ProductCommentService productCommentService;
	
	@Autowired
	private VNPayService vnPayService;

	// Hiện thị view khách hàng và thanh toán
	@RequestMapping(value = "/checkout", method = RequestMethod.GET)
	public String checkOut(final Model model, final HttpServletRequest request) throws IOException {
		HttpSession session = request.getSession();
		Cart cart = (Cart) session.getAttribute("cart");
		if (cart != null) {
			model.addAttribute("totalCartPrice", cart.totalCartPrice());
		}
		return "frontend/checkout";
	}

	// Chức năng Đặt hàng sản phẩm trong giỏ hàng
	@RequestMapping(value = "/place-order", method = RequestMethod.POST)
	ResponseEntity<Map<String, Object>> placeOrder(@RequestBody Customer customer, final HttpServletRequest request)
			throws IOException {

		Map<String, Object> jsonResult = new HashMap<String, Object>(); // Gửi lại view
		jsonResult.put("code", 200);

		Boolean isCheck = true;
		// Kiểm tra thông tin customer bắt buộc
		if (StringUtils.isEmpty(customer.getTxtName())) {
			isCheck = false;
			jsonResult.put("message", "Bạn chưa nhập họ tên");
		} else if (StringUtils.isEmpty(customer.getTxtMobile())) {
			isCheck = false;
			jsonResult.put("message", "Bạn chưa nhập Số điện thoại");
		} else if (StringUtils.isEmpty(customer.getTxtEmail())) {
			isCheck = false;
			jsonResult.put("message", "Bạn chưa nhập Email");
		} else if (StringUtils.isEmpty(customer.getTxtAddress())) {
			isCheck = false;
			jsonResult.put("message", "Bạn chưa nhập địa chỉ");
		} else {
			HttpSession session = request.getSession();
			Cart cart = (Cart) session.getAttribute("cart");
			if (cart == null || cart.totalCartProduct().equals(BigInteger.ZERO)) {
				jsonResult.put("message", "Bạn chưa có giỏ hàng");
			} else {
				// Lưu các sản phẩm trong giỏ hàng vào DB: tbl_sale_order_product
				SaleOrder saleOrder = new SaleOrder();
				for (ProductCart productCart : cart.getProductCarts()) {
					SaleOrderProduct saleOrderProduct = new SaleOrderProduct();
					// Lấy product trong db
					Product dbProduct = productService.getById(productCart.getProductId());
					BigInteger cartQuantity = productCart.getQuantity();
					BigInteger currentQuantity = BigInteger.valueOf(dbProduct.getProductQuantity());
					BigInteger updatedQuantity = currentQuantity.subtract(cartQuantity);
					
					// Cập nhật giá trị mới cho productQuantity
					dbProduct.setProductQuantity(updatedQuantity.intValue());
					
					saleOrderProduct.setProduct(dbProduct);
					saleOrderProduct.setQuantity(productCart.getQuantity().intValue());
					saleOrderProduct.setSize(productCart.getSize()); // luu size
					saleOrderProduct.setCreateDate(new Date());
					saleOrderProduct.setStatus(EnumStatus.ACTIVE);
					saleOrder.addRelationalSaleOrderProduct(saleOrderProduct);
					
					// Lưu đơn hàng tạo 1 comment của người dùng đã mua sản phẩm đó
					ProductComment newProductComment = new ProductComment(dbProduct, getLoginedUser());
					productCommentService.saveOrUpdate(newProductComment);
				}
				// Luu đơn hàng vào tbl_sale_order
				Calendar calendar = Calendar.getInstance();
				String code = customer.getTxtMobile() + calendar.get(Calendar.YEAR) + calendar.get(calendar.MONTH)
						+ calendar.get(calendar.DAY_OF_MONTH);

				saleOrder.setCode(code);

				// Lấy thông tin người dùng hiện tại từ Spring Security
				Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
				if (authentication != null && authentication.getPrincipal() instanceof User) {
					User user = (User) authentication.getPrincipal();
					saleOrder.setUser(user);
					saleOrder.setUserCreateSaleOrder(user);
				} 

				saleOrder.setStatus(EnumStatus.PENDING_PROCESSING); // trang thai mua hang
				saleOrder.setCreateDate(new Date()); // ngay mua

				saleOrder.setCustomerName(customer.getTxtName()); // luu ten khach hang
				saleOrder.setCustomerMobile(customer.getTxtMobile()); // luu so dien thoai
				saleOrder.setCustomerEmail(customer.getTxtEmail()); // luu email
				saleOrder.setCustomerAddress(customer.getTxtAddress()); // luu dia chi
				saleOrder.setNote(customer.getTxtNote()); // luu ghi chut Note
				saleOrder.setPaymentMethod(false);
				saleOrder.setTotal(cart.totalCartPrice()); // gia phai tra

				// Luu vao DB tb_sale_order
				saleOrderService.saveOrder(saleOrder);
				session.setAttribute("OrderDetailOfCart", cart);
//				// Xóa giỏ hàng sau khi đã đặt hàng
				cart = new Cart();
				session.setAttribute("cart", cart);
				
				Date orderDate = new Date();
				SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
				String orderDateTime = dateFormat.format(orderDate);
				jsonResult.put("orderDateTime", orderDateTime);
			}
		}
		jsonResult.put("isCheck", isCheck);
		// Tra ve du lieu cho view
		return ResponseEntity.ok(jsonResult);
	}
	
	@RequestMapping(value = "/payment", method = RequestMethod.POST)
	ResponseEntity<Map<String, Object>> Payment(@RequestBody Customer customer, final HttpServletRequest request)
			throws IOException {

		Map<String, Object> jsonResult = new HashMap<String, Object>(); // Gửi lại view
		jsonResult.put("code", 200);

		Boolean isCheck = true;
		// Kiểm tra thông tin customer bắt buộc
		if (StringUtils.isEmpty(customer.getTxtName())) {
			isCheck = false;
			jsonResult.put("message", "Bạn chưa nhập họ tên");
		} else if (StringUtils.isEmpty(customer.getTxtMobile())) {
			isCheck = false;
			jsonResult.put("message", "Bạn chưa nhập Số điện thoại");
		} else if (StringUtils.isEmpty(customer.getTxtEmail())) {
			isCheck = false;
			jsonResult.put("message", "Bạn chưa nhập Email");
		} else if (StringUtils.isEmpty(customer.getTxtAddress())) {
			isCheck = false;
			jsonResult.put("message", "Bạn chưa nhập địa chỉ");
		} else {
			HttpSession session = request.getSession();
			Cart cart = (Cart) session.getAttribute("cart");
			if (cart == null || cart.totalCartProduct().equals(BigInteger.ZERO)) {
				jsonResult.put("message", "Bạn chưa có giỏ hàng");
			} else {
				// Lưu các sản phẩm trong giỏ hàng vào DB: tbl_sale_order_product
				SaleOrder saleOrder = new SaleOrder();
				for (ProductCart productCart : cart.getProductCarts()) {
					SaleOrderProduct saleOrderProduct = new SaleOrderProduct();
					// Lấy product trong db
					Product dbProduct = productService.getById(productCart.getProductId());
					BigInteger cartQuantity = productCart.getQuantity();
					BigInteger currentQuantity = BigInteger.valueOf(dbProduct.getProductQuantity());
					BigInteger updatedQuantity = currentQuantity.subtract(cartQuantity);
					
					// Cập nhật giá trị mới cho productQuantity
					dbProduct.setProductQuantity(updatedQuantity.intValue());
					
					saleOrderProduct.setProduct(dbProduct);
					saleOrderProduct.setQuantity(productCart.getQuantity().intValue());
					saleOrderProduct.setSize(productCart.getSize()); // luu size
					saleOrderProduct.setCreateDate(new Date());
					saleOrderProduct.setStatus(EnumStatus.ACTIVE);
					saleOrder.addRelationalSaleOrderProduct(saleOrderProduct);
					
					// Lưu đơn hàng tạo 1 comment của người dùng đã mua sản phẩm đó
					ProductComment newProductComment = new ProductComment(dbProduct, getLoginedUser());
					productCommentService.saveOrUpdate(newProductComment);
				}
				// Luu đơn hàng vào tbl_sale_order
				Calendar calendar = Calendar.getInstance();
				String code = customer.getTxtMobile() + calendar.get(Calendar.YEAR) + calendar.get(calendar.MONTH)
						+ calendar.get(calendar.DAY_OF_MONTH);

				saleOrder.setCode(code);

				// Lấy thông tin người dùng hiện tại từ Spring Security
				Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
				if (authentication != null && authentication.getPrincipal() instanceof User) {
					User user = (User) authentication.getPrincipal();
					saleOrder.setUser(user);
					saleOrder.setUserCreateSaleOrder(user);
				} 

				//saleOrder.setStatus(EnumStatus.PENDING_PROCESSING); // trang thai mua hang
				saleOrder.setCreateDate(new Date()); // ngay mua

				saleOrder.setCustomerName(customer.getTxtName()); // luu ten khach hang
				saleOrder.setCustomerMobile(customer.getTxtMobile()); // luu so dien thoai
				saleOrder.setCustomerEmail(customer.getTxtEmail()); // luu email
				saleOrder.setCustomerAddress(customer.getTxtAddress()); // luu dia chi
				saleOrder.setNote(customer.getTxtNote()); // luu ghi chut Note
				saleOrder.setPaymentMethod(true);
				saleOrder.setTotal(cart.totalCartPrice()); // gia phai tra

				// Luu vao DB tb_sale_order
				SaleOrder saleOrder2 =  saleOrderService.saveOrder(saleOrder);
				
				String Url  = vnPayService.createOrder(saleOrder2.getTotal().intValue(), saleOrder2.getId().toString(), request);
				jsonResult.put("Url", Url);
				// Xóa giỏ hàng sau khi đã đặt hàng
				cart = new Cart();
				session.setAttribute("cart", cart);							
			}
		}
		jsonResult.put("isCheck", isCheck);
		// Tra ve du lieu cho view
		return ResponseEntity.ok(jsonResult);
	}
}
