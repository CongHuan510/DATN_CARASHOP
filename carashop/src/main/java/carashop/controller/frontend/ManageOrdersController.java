package carashop.controller.frontend;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import carashop.controller.BaseController;
import carashop.dto.Jw27Constants;
import carashop.dto.SearchModel;
import carashop.model.SaleOrder;
import carashop.model.SaleOrderProduct;
import carashop.model.User;
import carashop.service.SaleOrderProductService;
import carashop.service.SaleOrderService;

@Controller
public class ManageOrdersController extends BaseController implements Jw27Constants {

	@Autowired
	private SaleOrderService saleOrderService;

	@Autowired
	private SaleOrderProductService saleOrderProductService;

	@RequestMapping(value = "/manageorders", method = RequestMethod.GET)
	public String getOrders(final Model model, final HttpServletRequest request) {
		SearchModel orrderSearch = new SearchModel();
		// Lấy user theo id từ Spring security
		Object loginedUser = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		if (loginedUser != null && loginedUser instanceof UserDetails) {
			User user = (User) loginedUser;
			int userId = user.getId();

			// Bat dau phan trang
			if (!StringUtils.isEmpty(request.getParameter("currentPage"))) { // Bam nut chuyen trang
				orrderSearch.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
			} else {
				orrderSearch.setCurrentPage(1); // lan dau truy cap luon hien thi trang 1
			}

			// Lấy ra các đơn hàng theo userId
			List<SaleOrder> allOrders = saleOrderService.getOrdersByUserId(userId);
			List<SaleOrder> saleOrders = new ArrayList<SaleOrder>();

			// Tổng số trang theo tìm kiếm
			int totalPages = allOrders.size() / SIZE_OF_PAGE;
			if (allOrders.size() % SIZE_OF_PAGE > 0) {
				totalPages++;
			}

			// Nếu tổng số trang nhỏ hơn trang hiện tại
			if (totalPages < orrderSearch.getCurrentPage()) {
				orrderSearch.setCurrentPage(1);
			}

			// Lấy danh sách sp cần hiển thị trong 1 trang
			int firstIndex = (orrderSearch.getCurrentPage() - 1) * SIZE_OF_PAGE; // vị trí đầu 1 trang
			int index = firstIndex, count = 0;
			while (index < allOrders.size() && count < SIZE_OF_PAGE) {
				saleOrders.add(allOrders.get(index));
				index++;
				count++;
			}

			// Phan trang
			orrderSearch.setSizeOfPage(SIZE_OF_PAGE); // So ban ghi tren 1 trang
			orrderSearch.setTotalItems(allOrders.size()); // Tong so san pham theo tim kiem
			// Lưu trữ các sản phẩm của mỗi đơn hàng
			Map<Integer, List<SaleOrderProduct>> orderProductMap = new HashMap<>();
			for (SaleOrder saleOrder : allOrders) {
				int orderId = saleOrder.getId();
				// System.out.println(orderId);
				List<SaleOrderProduct> saleOrderProducts = saleOrderProductService.getProductsByOrderId(orderId);
				// Lưu trữ danh sách sản phẩm theo orderId
				orderProductMap.put(orderId, saleOrderProducts);
			}
			// Thêm danh sách sản phẩm và danh sách đơn hàng vào model
			model.addAttribute("orderProductMap", orderProductMap);
			model.addAttribute("saleOrders", saleOrders);
			model.addAttribute("orrderSearch", orrderSearch);

			// Lấy URL hiện tại và thêm tham số phân trang vào URL
			String currentUrl = request.getRequestURI();
			String paginationUrl = currentUrl + "?currentPage=";

			// Truyền URL phân trang vào model
			model.addAttribute("paginationUrl", paginationUrl);

		}
		return "frontend/manageorders";
	}
}
