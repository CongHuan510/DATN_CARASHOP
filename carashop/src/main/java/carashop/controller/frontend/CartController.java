package carashop.controller.frontend;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import carashop.controller.BaseController;
import carashop.dto.Cart;

import carashop.dto.Jw27Constants;
import carashop.dto.ProductCart;
import carashop.model.Product;
import carashop.service.ProductService;

@Controller
public class CartController extends BaseController implements Jw27Constants {

	@Autowired
	private ProductService productService;

	// Chức năng thêm mới 1 sản phẩm vào trong giỏ hàng
	@RequestMapping(value = "/add-to-cart", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addToCart(final Model model, final HttpServletRequest request,
			@RequestBody ProductCart addProduct) throws IOException {
		
		Map<String, Object> jsonResult = new HashMap<String, Object>();
		HttpSession session = request.getSession();
		Cart cart = null;
		// Kiểm tra người dùng đã đăng nhập chưa
	    Object loginedUser = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	    if (loginedUser != null && loginedUser instanceof UserDetails) {
	    	// Lấy giỏ hàng ra trong session
			// Kiểm tra giỏ hàng đã được tạo trong session chưa
			if (session.getAttribute("cart") != null) { // TH: Đã có trong giỏ hàng
				cart = (Cart) session.getAttribute("cart"); // Lấy giỏ hàng ra
			} else { // TH: chưa có => tạo mới giỏ hàng
				cart = new Cart();
				session.setAttribute("cart", cart);
			}
			// Lấy sản phẩm trong DBr
			Product dbProduct = productService.getById(addProduct.getProductId());
			BigInteger productQuantity = BigInteger.valueOf(dbProduct.getProductQuantity());
						
			String size = addProduct.getSize(); // lấy giá trị kích cỡ	
			int index = cart.findProductByIdAndSize(dbProduct.getId(), size); // tồn tại sp trong giỏ	  
			// Tính tổng số lượng sản phẩm cùng một loại có trong giỏ hàng
			BigInteger totalQuantityInCart = calculateTotalQuantityInCart(cart, dbProduct.getId());
			// Tính tổng số lượng sản phẩm mua mới và cập nhật giỏ hàng
			BigInteger newQuantity = addProduct.getQuantity();
			// Kiểm tra tổng số lượng sản phẩm trong giỏ hàng sau khi thêm sản phẩm mới
			if (totalQuantityInCart.add(newQuantity).compareTo(productQuantity) > 0) { // vượt quá
			    jsonResult.put("errorMessage", "Số lượng sản phẩm " + dbProduct.getName() + " không đủ hàng!");
			    return ResponseEntity.badRequest().body(jsonResult);
			}
			if (index != -1) { // Có cho phép tăng số lượng sản phẩm
				 BigInteger totalQuantityAfterAdding = totalQuantityInCart.add(newQuantity);
				    if (totalQuantityAfterAdding.compareTo(productQuantity) <= 0) { // không vượt quá
				    	cart.getProductCarts().get(index).setQuantity(
					            cart.getProductCarts().get(index).getQuantity().add(addProduct.getQuantity()));
				    } else {
				        jsonResult.put("errorMessage", "Số lượng sản phẩm " + dbProduct.getName() + " không đủ!");
				        return ResponseEntity.badRequest().body(jsonResult);
				    }
			} else { // SAN PHAM CHUA CO TRONG GIO HANG
				// Kiểm tra xem có size được chọn từ trang JSP không
	            if (addProduct.getSize() != null && !addProduct.getSize().isEmpty()) {
	                addProduct.setSize(addProduct.getSize());
	            } else {
	               // mặc định lấy size đầu tiên từ danh sách sizes của sản phẩm
	                addProduct.setSize(dbProduct.getSize().split(",")[0]);
	            }          
	            if (addProduct.getQuantity().compareTo(productQuantity) > 0) {
					jsonResult.put("errorMessage", "Số lượng sản phẩm " + dbProduct.getName() + " không đủ!");
					return ResponseEntity.badRequest().body(jsonResult);
				}
				addProduct.setProductName(dbProduct.getName());
				addProduct.setAvatar(dbProduct.getAvatar());
				if (dbProduct.getSalePrice() != null) {
				    addProduct.setPrice(dbProduct.getSalePrice());
				} else {
				    addProduct.setPrice(dbProduct.getPrice());
				}
				cart.getProductCarts().add(addProduct);// them san pham moi vao gio hang
			}
			// Thiết lập lại giỏ hàng trong session
			session.setAttribute("cart", cart);
			// Trả về dữ liệu cho view
			jsonResult.put("totalCartProducts", cart.totalCartProduct());
			jsonResult.put("message", "Đã thêm sản phẩm " + addProduct.getProductName() + " vào giỏ hàng thành công!");
	        
	    }  else {
	        // Trả về thông báo lỗi khi người dùng chưa đăng nhập
	        jsonResult.put("errorMessage", "Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng!");
	    }
		return ResponseEntity.ok(jsonResult);
	}
	
	private BigInteger calculateTotalQuantityInCart(Cart cart, int productId) {
	    BigInteger totalQuantity = BigInteger.ZERO;
	    for (ProductCart productCart : cart.getProductCarts()) {
	        if (productCart.getProductId() == productId) {
	            totalQuantity = totalQuantity.add(productCart.getQuantity());
	        }
	    }
	    return totalQuantity;
	}

	
	// Hiển thị view giỏ hàng
	@RequestMapping(value = "/cart-view", method = RequestMethod.GET)
	public String cartView(final Model model, final HttpServletRequest request) throws IOException {
	    HttpSession session = request.getSession();
	    if (session.getAttribute("cart") != null) {
	        Cart cart = (Cart) session.getAttribute("cart");
	        if (cart.totalCartProduct().compareTo(BigInteger.ZERO) > 0) {
	            model.addAttribute("totalCartPrice", cart.totalCartPrice());
	            String message = "Có tổng cộng " + cart.totalCartProduct() + " sản phẩm trong giỏ hàng của bạn";
	            model.addAttribute("message", message);
	            model.addAttribute("totalCartProducts", cart.totalCartProduct());
	        } else {
	            String errorMessage = "Không có sản phẩm nào trong giỏ hàng của bạn!";
	            model.addAttribute("errorMessage", errorMessage);
	        }
	    } else {
	        String errorMessage = "Không có sản phẩm nào trong giỏ hàng của bạn!";
	        model.addAttribute("errorMessage", errorMessage);
	    }

	    return "frontend/cart-view";
	}

	// Them/bot so luong san pham trong gio hang
	@RequestMapping(value = "/update-product-quantity", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> updateProductQuantity(final HttpServletRequest request,
	        @RequestBody ProductCart productCart) throws IOException {
	    HttpSession session = request.getSession();
	    Map<String, Object> jsonResult = new HashMap<String, Object>();
	    if (session.getAttribute("cart") != null) {
	        Cart cart = (Cart) session.getAttribute("cart");
	        String size = productCart.getSize();
	       
	        // Lấy số lượng sản phẩm từ cơ sở dữ liệu
	        Product dbProduct = productService.getById(productCart.getProductId());
	        BigInteger productQuantity = BigInteger.valueOf(dbProduct.getProductQuantity());
	     // Tính tổng số lượng các sản phẩm có cùng ID nhưng khác kích thước trong giỏ hàng
	        BigInteger totalQuantityInCart = calculateTotalQuantityInCart(cart, productCart.getProductId());
	        if (totalQuantityInCart.compareTo(productQuantity) >= 0 && productCart.getQuantity().compareTo(BigInteger.ZERO) > 0) {
	            jsonResult.put("errorMessage", "Số lượng sản phẩm " + dbProduct.getName() + " không đủ!");
	            return ResponseEntity.badRequest().body(jsonResult);
	        }
	        // Cap nhat so luong
	        int index = cart.findProductByIdAndSize(productCart.getProductId(), size);
	        if (index != -1) {
	            BigInteger oldQuantity = cart.getProductCarts().get(index).getQuantity();
	            BigInteger newQuantity = oldQuantity.add(productCart.getQuantity());
	            if (newQuantity.intValue() < 1) {
	                newQuantity = BigInteger.ONE;
	            }           	          	            
	            cart.getProductCarts().get(index).setQuantity(newQuantity);
	            //jsonResult.put("message", "Thêm số lượng sản phẩm " + dbProduct.getName() + " thành công!");
	            jsonResult.put("newQuantity", newQuantity);
	            jsonResult.put("totalCartProducts", cart.totalCartProduct());
	            
	            // Tính toán thành tiền mới
	            BigDecimal newTotalPrice = dbProduct.getPrice().multiply(new BigDecimal(newQuantity));
	            jsonResult.put("newTotalPrice", newTotalPrice);
	            
	            // Tính tổng thành tiền cho toàn bộ giỏ hàng
	            BigDecimal totalCartPrice = cart.totalCartPrice();
	            jsonResult.put("totalCartPrice", totalCartPrice);
	        }
	        
	    }
	    jsonResult.put("productId", productCart.getProductId());
	    // Tra ve du lieu cho view
	    return ResponseEntity.ok(jsonResult);
	}



	@RequestMapping(value = "/product-cart-delete/{productId}/{size}", method = RequestMethod.GET)
	public String deleteProductFromCart(@PathVariable("productId") int productId, 
	        @PathVariable("size") String size, HttpServletRequest request) {
	    HttpSession session = request.getSession();
	    if (session.getAttribute("cart") != null) {
	        Cart cart = (Cart) session.getAttribute("cart"); 
	        
	        //Tìm vị trí của sản phẩm trong giỏ hàng
	        int index = cart.findProductByIdAndSize(productId, size);
	        
	        if (index != -1) {
	            cart.getProductCarts().remove(index);
	        }
	        
	        // Thiết lập lại giỏ hàng trong session
	        session.setAttribute("cart", cart);
	    }
	    
	    return "redirect:/cart-view";
	}
}
