package carashop.controller.backend;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import carashop.controller.BaseController;
import carashop.dto.EnumStatus;
import carashop.model.Product;
import carashop.model.SaleOrder;
import carashop.model.SaleOrderProduct;
import carashop.model.User;
import carashop.service.SaleOrderProductService;
import carashop.service.SaleOrderService;
import carashop.service.UserService;

@Controller
@RequestMapping("/admin/")
public class HomeAdminController extends BaseController {

	@Autowired
	private UserService userService;

	@Autowired
	private SaleOrderService saleOrderService;

	@Autowired
	private SaleOrderProductService saleOrderProductService;

	@RequestMapping(value = "home", method = RequestMethod.GET)
	public String home(final Model model, final HttpServletRequest request) {

		// Thống kê sản phẩm đã bán theo số lượng
		List<SaleOrderProduct> saleOrderProducts = saleOrderProductService.findAllActive();
		int totalProducts = 0;
		for (SaleOrderProduct saleOrderProduct : saleOrderProducts) {
			if (saleOrderProduct.getSaleOrder().getStatus() == EnumStatus.DELIVERED) {
				totalProducts += saleOrderProduct.getQuantity();
			}
		
		}
		model.addAttribute("totalProducts", totalProducts);

		// Thống kê đơn hàng
		List<SaleOrder> saleOrders = saleOrderService.findAll();
		int orders = saleOrders.size();
		model.addAttribute("orders", orders);

		// Tính tổng doanh số bán hàng
		BigDecimal totalSales = BigDecimal.ZERO;
		// Duyệt qua danh sách đơn hàng và cộng dồn giá trị total của mỗi đơn
		for (SaleOrder saleOrder : saleOrders) {
		    // Kiểm tra xem đơn hàng có trạng thái là DELIVERED không
		    if (saleOrder.getStatus() == EnumStatus.DELIVERED) {
		        BigDecimal orderTotal;
		        if (saleOrder.getTotal() == null) {
		            orderTotal = BigDecimal.ZERO;
		        } else {
		            orderTotal = saleOrder.getTotal();
		        }

		        totalSales = totalSales.add(orderTotal);
		    }
		}
		// Thêm totalSales vào model
		model.addAttribute("totalSales", totalSales);


		// Thống kê khách hàng - admin trong user
		List<User> users = userService.findAllGuestUsers();
		int visitors = users.size();
		model.addAttribute("visitors", visitors);

		// Thống kê doanh thu theo tháng từ cơ sở dữ liệu
		String year = request.getParameter("year"); // lấy value từ view
		if (!StringUtils.isEmpty(year)) { // Neu co chon status
			List<BigDecimal> dashboardRevenue = saleOrderService.getMoneyByMonths(Integer.parseInt(year));
			//System.out.println(dashboardRevenue);
			// Đưa dữ liệu vào model
			model.addAttribute("dashboardRevenue", dashboardRevenue);
			List<BigInteger> dashboardOrder = saleOrderService.getOrderByMonths(Integer.parseInt(year));
			//System.out.println(dashboardOrder);
			// Đưa dữ liệu vào model
			model.addAttribute("dashboardOrder", dashboardOrder);
			
			List<BigDecimal> dashboardProduct = saleOrderService.getProductByMonths(Integer.parseInt(year));
			//System.out.println(dashboardProduct);
			// Đưa dữ liệu vào model
			model.addAttribute("dashboardProduct", dashboardProduct);
		}
		// lấy ra danh sách sản phẩm bán chạy nhất theo quantity từ bảng SaleOrderProduct
		// Thống kê sản phẩm đã bán theo số lượng
        List<Product> topSellingProducts = saleOrderProductService.findTopSellingProducts();
        model.addAttribute("topSellingProducts", topSellingProducts);

		return "backend/home";
	}
}
