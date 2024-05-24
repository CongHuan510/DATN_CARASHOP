package carashop.controller.backend;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import carashop.controller.BaseController;
import carashop.dto.EnumStatus;
import carashop.dto.Jw27Constants;
import carashop.dto.SearchModel;
import carashop.model.SaleOrder;
import carashop.model.SaleOrderProduct;
import carashop.service.SaleOrderProductService;
import carashop.service.SaleOrderService;

@Controller
@RequestMapping("/admin/order/")
public class OrderControler extends BaseController implements Jw27Constants {
	@Autowired
	private SaleOrderService saleOrderService;

	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(final Model model, final HttpServletRequest request) {

		SearchModel saleOrderSearch = new SearchModel();
		// Tìm theo status
		saleOrderSearch.setStatus("ALL");
		String status = request.getParameter("status");
		if (!StringUtils.isEmpty(status)) { // Neu co chon status
			saleOrderSearch.setStatus(status);
		}

		// Tim theo key
		saleOrderSearch.setKeyword(null);
		String keyword = request.getParameter("keyword");
		if (!StringUtils.isEmpty(keyword)) { // Neu nhap key word
			saleOrderSearch.setKeyword(keyword);
		}

		// Kiem tra tieu chi tim kiem tu ngay den ngay
		String beginDate = null;
		String endDate = null;
		if (!StringUtils.isEmpty(request.getParameter("beginDate"))
				&& !StringUtils.isEmpty(request.getParameter("endDate"))) {
			beginDate = request.getParameter("beginDate");
			endDate = request.getParameter("endDate");
		}
		saleOrderSearch.setBeginDate(beginDate);
		saleOrderSearch.setEndDate(endDate);

		// Bat dau phan trang
		if (!StringUtils.isEmpty(request.getParameter("currentPage"))) {
			saleOrderSearch.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		} else {
			saleOrderSearch.setCurrentPage(1);
		}

		List<SaleOrder> allSaleOrders = saleOrderService.searchOrder(saleOrderSearch);
		List<SaleOrder> saleOrders = new ArrayList<SaleOrder>();

		// Tong so trang theo tim kiem
		int totalPages = allSaleOrders.size() / SIZE_OF_PAGE;
		if (allSaleOrders.size() % SIZE_OF_PAGE > 0) {
			totalPages++;
		}

		// Nếu tổng số trang < trang hiện tại
		if (totalPages < saleOrderSearch.getCurrentPage()) {
			saleOrderSearch.setCurrentPage(1);
		}

		// Lay danh sach sp can hien thi trong 1 trang
		int firstIndex = (saleOrderSearch.getCurrentPage() - 1) * SIZE_OF_PAGE; // vị trị dau 1 trang
		int index = firstIndex, count = 0;
		while (index < allSaleOrders.size() && count < SIZE_OF_PAGE) {
			saleOrders.add(allSaleOrders.get(index));
			index++;
			count++;
		}

		// Phan trang
		saleOrderSearch.setSizeOfPage(SIZE_OF_PAGE); // So ban ghi tren 1 trang
		saleOrderSearch.setTotalItems(allSaleOrders.size()); // Tong so san pham theo tim kiem

//		List<SaleOrder> saleOrders = saleOrderService.searchOrder(searchOrderSearch);
		// Đảm bảo rằng ngày tạo không phải là null
//		for (SaleOrder saleOrder : allSaleOrders) {
//			if (saleOrder.getCreateDate() == null) {
//				saleOrder.setCreateDate(new Date());
//			
//			}
//			saleOrderService.saveOrder(saleOrder);
//			
//			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//			if (authentication != null && authentication.getPrincipal() instanceof User) {
//			    User user = (User) authentication.getPrincipal();
//			    saleOrder.setUserCreateSaleOrder(user);
//			}
//		}

		// Tính tổng doanh số bán hàng
		BigDecimal totalSales = BigDecimal.ZERO;

		// Duyệt qua danh sách đơn hàng và cộng dồn giá trị total của mỗi đơn
		for (SaleOrder saleOrder : allSaleOrders) {
			BigDecimal orderTotal;

			if (saleOrder.getTotal() == null) {
				orderTotal = BigDecimal.ZERO;
			} else {
				orderTotal = saleOrder.getTotal();
			}

			totalSales = totalSales.add(orderTotal);
		}
		// Thêm totalSales vào model
		model.addAttribute("totalSales", totalSales);
		model.addAttribute("saleOrders", saleOrders);
		model.addAttribute("saleOrderSearch", saleOrderSearch);

		// Lưu trữ các sản phẩm của mỗi đơn hàng
		Map<Integer, List<SaleOrderProduct>> orderProductMap = new HashMap<>();
		for (SaleOrder saleOrder : allSaleOrders) {
			int orderId = saleOrder.getId();
			// System.out.println(orderId);
			List<SaleOrderProduct> saleOrderProducts = saleOrderProductService.getProductsByOrderId(orderId);
			// Lưu trữ danh sách sản phẩm theo orderId
			orderProductMap.put(orderId, saleOrderProducts);
		}
		model.addAttribute("orderProductMap", orderProductMap);
		return "backend/order-list";
	}

	// EDIT ORDER
//	@RequestMapping(value = "edit/{saleOrderId}", method = RequestMethod.GET)
//	// Đẩy 1 dữ liệu sang view
//	public String edit(final Model model, @PathVariable("saleOrderId") int saleOrderId) {
//
//		List<User> users = userService.findAll();
//		model.addAttribute("users", users);
//
//		// Lấy order trong DB bằng id
//		SaleOrder saleOrder = saleOrderService.getById(saleOrderId);
//		model.addAttribute("saleOrder", saleOrder);
//		return "backend/order-edit";
//	}
//
//	// SAVE EDIT ORDER
//	@RequestMapping(value = "/edit-save", method = RequestMethod.POST)
//	public String editSave(final Model model, @ModelAttribute("saleOrder") SaleOrder saleOrder) {
//		saleOrderService.saveOrder(saleOrder);
//		return "redirect:/admin/order/list";
//	}

	// DELETE ORDER
	@RequestMapping(value = "delete/{saleOrderId}", method = RequestMethod.GET)
	// Cách đẩy 1 dữ liệu sang view
	public String delete(final Model model, @PathVariable("saleOrderId") int saleOrderId) {

		SaleOrder saleOrder = saleOrderService.getById(saleOrderId);
		saleOrder.setStatus(EnumStatus.CANCELED);
		saleOrderService.inactiveSaleOrder(saleOrder);
		return "redirect:/admin/order/list";
	}

	@RequestMapping(value = "status/{saleOrderId}", method = RequestMethod.GET)
	// Cách đẩy 1 dữ liệu sang view
	public String changeStatus(final Model model, @PathVariable("saleOrderId") int saleOrderId) {

		SaleOrder saleOrder = saleOrderService.getById(saleOrderId);
		// System.out.println(saleOrder.getStatus());
		if (saleOrder.getStatus().equals(EnumStatus.PENDING_PROCESSING)) {
			saleOrder.setStatus(EnumStatus.PROCESSED);
		} else if (saleOrder.getStatus().equals(EnumStatus.PROCESSED)) {
			saleOrder.setStatus(EnumStatus.ON_DELIVERY);
		} else if (saleOrder.getStatus().equals(EnumStatus.ON_DELIVERY)) {
			saleOrder.setStatus(EnumStatus.DELIVERED);
		} else if (saleOrder.getStatus().equals(EnumStatus.PAID)) {
			saleOrder.setStatus(EnumStatus.ON_DELIVERY);
		} else {
			saleOrder.setStatus(EnumStatus.CANCELED);
		}

		saleOrderService.inactiveSaleOrder(saleOrder);
		return "redirect:/admin/order/list";
	}

	@Autowired
	private SaleOrderProductService saleOrderProductService;

	// DETAIL ORDER
	@RequestMapping(value = "detail/{saleOrderId}", method = RequestMethod.GET)
	// Đẩy 1 dữ liệu sang view
	public String detail(final Model model, @PathVariable("saleOrderId") int saleOrderId) {

		// Lấy order trong DB bằng id để hiện thông tin khách hàng
		SaleOrder saleOrder = saleOrderService.getById(saleOrderId);
		model.addAttribute("saleOrder", saleOrder);

		// lấy các thông tin sản phẩm từ thằng productCart
		List<SaleOrderProduct> saleOrderProducts = saleOrderProductService.findAllProductInOrder(saleOrderId);

		// Tính tổng doanh số bán hàng
		BigDecimal totalSales = BigDecimal.ZERO;
		for (SaleOrderProduct saleOrderProduct : saleOrderProducts) {
			int quantity = saleOrderProduct.getQuantity();
			BigDecimal price = saleOrderProduct.getProduct().getPrice();
			totalSales = totalSales.add(price.multiply(BigDecimal.valueOf(quantity)));
		}

		model.addAttribute("totalSales", totalSales);
		model.addAttribute("saleOrderProducts", saleOrderProducts);

		return "backend/order-detail";

	}
}
