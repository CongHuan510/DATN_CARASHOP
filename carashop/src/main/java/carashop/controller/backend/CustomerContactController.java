package carashop.controller.backend;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import carashop.controller.BaseController;
import carashop.dto.EnumStatus;
import carashop.dto.Jw27Constants;
import carashop.dto.SearchModel;
import carashop.model.CustomerContact;
import carashop.model.User;
import carashop.service.CustomerContactService;
import carashop.service.UserService;

@Controller
@RequestMapping("/admin/")
public class CustomerContactController extends BaseController implements Jw27Constants {

	@Autowired
	private CustomerContactService customerContactService;
	
	@Autowired
	private UserService userService;

	// -------------------------LIST CUSTOMER CONTACT ------------------------------
	@RequestMapping(value = "customer-contact", method = RequestMethod.GET)
	public String customerContact(final Model model, final HttpServletRequest request) {
		SearchModel contactSearch = new SearchModel();
		// Tìm theo status
		contactSearch.setStatus("ALL");
		String status = request.getParameter("status");
		if (!StringUtils.isEmpty(status)) {
			contactSearch.setStatus(status);
		}
		// Tìm theo key
		contactSearch.setKeyword(null);
		String keyword = request.getParameter("keyword");
		if (!StringUtils.isEmpty(keyword)) {
			contactSearch.setKeyword(keyword);
		}
		// Tìm theo từ khoảng [] ngày
		String beginDate = null;
		String endDate = null;
		if (!StringUtils.isEmpty(request.getParameter("beginDate"))
				&& !StringUtils.isEmpty(request.getParameter("endDate"))) {
			beginDate = request.getParameter("beginDate");
			endDate = request.getParameter("endDate");
		}
		contactSearch.setBeginDate(beginDate);
		contactSearch.setEndDate(endDate);
		// Bat dau phan trang
		if (!StringUtils.isEmpty(request.getParameter("currentPage"))) { // Bam nut chuyen trang
			contactSearch.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		} else {
			contactSearch.setCurrentPage(1); // lan dau truy cap luon hien thi trang 1
		}
		List<CustomerContact> allCustomerContacts = customerContactService.searchCustomerContact(contactSearch);// Tim																								// kiem
		List<CustomerContact> customerContacts = new ArrayList<CustomerContact>(); // DS sp can hien thi trang hien tai
		// Tong so trang theo tim kiem
		int totalPages = allCustomerContacts.size() / SIZE_OF_PAGE;
		if (allCustomerContacts.size() % SIZE_OF_PAGE > 0) {
			totalPages++;
		}
		// Neu tong so trang < trang hien tai (lai bam tim kiem)
		if (totalPages < contactSearch.getCurrentPage()) {
			contactSearch.setCurrentPage(1);
		}
		// Lay danh sach sp can hien thi trong 1 trang
		int firstIndex = (contactSearch.getCurrentPage() - 1) * SIZE_OF_PAGE; // vị trị dau 1 trang
		int index = firstIndex, count = 0;
		while (index < allCustomerContacts.size() && count < SIZE_OF_PAGE) {
			customerContacts.add(allCustomerContacts.get(index));
			index++;
			count++;
		}
		// Phan trang
		contactSearch.setSizeOfPage(SIZE_OF_PAGE); // So ban ghi tren 1 trang
		contactSearch.setTotalItems(allCustomerContacts.size()); // Tong so san pham theo tim kiem
		model.addAttribute("contactSearch", contactSearch);
		model.addAttribute("customerContacts", customerContacts);
		return "backend/customer-contact";
	}

	// DETAIL CUSTOMER-CONTACT
	@RequestMapping(value = "customer-contact/detail/{contactId}", method = RequestMethod.GET)
	// Đẩy 1 dữ liệu sang view
	public String detail(final Model model, @PathVariable("contactId") int contactId) {
		List<User> users = userService.findAll();
		model.addAttribute("users", users);

		CustomerContact customerContact = customerContactService.getById(contactId);
		model.addAttribute("customerContact", customerContact);
		return "backend/customer-contact-detail";

	}
	// EDIT CUSTOMER-CONTACT
	@RequestMapping(value = "customer-contact/edit/{contactId}", method = RequestMethod.GET)
	public String edit(final Model model, @PathVariable("contactId") int contactId) {
		List<User> users = userService.findAll();
		model.addAttribute("users", users);

		CustomerContact customerContact = customerContactService.getById(contactId);
		model.addAttribute("customerContact", customerContact);
		return "backend/customer-contact-edit";
	}

	// SAVE EDIT CUSTOMER-CONTACT
	@RequestMapping(value = "customer-contact/edit-save", method = RequestMethod.POST)
	// Cách đẩy 1 dữ liệu sang view
	public String editSave(final Model model, @ModelAttribute("customerContact") CustomerContact customerContact) {
		customerContactService.saveOrUpdate(customerContact);
		return "redirect:/admin/customer-contact";
	}

	// DELETE CUSTOMER-CONTACT
	@RequestMapping(value = "customer-contact/delete/{contactId}", method = RequestMethod.GET)
	public String delete(final Model model, @PathVariable("contactId") int contactId) {

		CustomerContact customerContact = customerContactService.getById(contactId);
		customerContact.setStatus(EnumStatus.INACTIVE);
		customerContactService.inactiveCustomerContact(customerContact);
		return "redirect:/admin/customer-contact";
	}
}
