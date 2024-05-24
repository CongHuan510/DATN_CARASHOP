package carashop.controller.frontend;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.beans.factory.annotation.Autowired;

import carashop.controller.BaseController;
import carashop.dto.EnumStatus;
import carashop.model.SaleOrder;
import carashop.service.SaleOrderService;
import carashop.service.VNPayService;

@Controller
public class VNPayController extends BaseController {

	@Autowired
	private VNPayService vnpayService;
	
	@Autowired
	private SaleOrderService saleOrderService;

	@RequestMapping(value = "/vnpay_return", method = RequestMethod.GET)
	public String vnPayReturn(final HttpServletRequest request, final Model model) throws IOException {
		int result = vnpayService.orderReturn(request);
		String vnp_OrderInfo = request.getParameter("vnp_OrderInfo");
		if (!StringUtils.isEmpty(vnp_OrderInfo)) {
			//System.out.println(vnp_OrderInfo);
			int orderId = Integer.parseInt(vnp_OrderInfo);
			SaleOrder saleOrder = saleOrderService.getById(orderId);
			
			if (result == 1) {
				saleOrder.setStatus(EnumStatus.PAID);
				
				model.addAttribute("message", "Thanh toán thành công");
				model.addAttribute("result", result);
			} else if (result == 0) {
				saleOrder.setStatus(EnumStatus.UNPAID);
				model.addAttribute("message", "Thanh toán thất bại");
				model.addAttribute("result", result);
			} else {
				model.addAttribute("message", "Có lỗi xảy ra");
				model.addAttribute("result", "error");
			}
			saleOrderService.saveOrUpdate(saleOrder);
		}
		return "frontend/vnpay_return";
	}
}
