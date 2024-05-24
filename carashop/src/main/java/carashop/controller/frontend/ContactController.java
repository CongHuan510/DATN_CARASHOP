package carashop.controller.frontend;

//import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
//import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.multipart.MultipartFile;

import carashop.controller.BaseController;
import carashop.dto.Contact;
import carashop.dto.EnumStatus;
import carashop.dto.Jw27Constants;
import carashop.model.CustomerContact;
import carashop.service.CustomerContactService;

@Controller
public class ContactController extends BaseController implements Jw27Constants{
	
	@Autowired
	private CustomerContactService customerContactService;
	
	// Để view trang method --> GET
	@RequestMapping(value = "/contact", method = RequestMethod.GET)
	public String contact(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {
		return "frontend/contact/contact";
	}
	
	@RequestMapping(value = "/contact-send", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> contactEditSave(final Model model, 
			final HttpServletRequest request, 
			final HttpServletResponse response,
			@RequestBody Contact contact)
			throws IOException {
		
		//Sau khi lưu giữ liệu vào DB;
		Map<String, Object> jsonResult = new HashMap<String, Object>(); // Gửi trở lại view
		jsonResult.put("code", 200);
		if (StringUtils.isEmpty(contact.getTxtName())) {
			jsonResult.put("errorMessage", "Bạn chưa nhập họ và tên");
		} else if (StringUtils.isEmpty(contact.getTxtMobile())) {
			jsonResult.put("errorMessage", "Bạn chưa nhập Số điện thoại");
		} else if (StringUtils.isEmpty(contact.getTxtEmail())) {
			jsonResult.put("errorMessage", "Bạn chưa nhập Email");
		} else if (StringUtils.isEmpty(contact.getTxtAddress())) {
			jsonResult.put("errorMessage", "Bạn chưa nhập địa chỉ");
		} else {
			CustomerContact customerContact = new CustomerContact();
			customerContact.setStatus(EnumStatus.ACTIVE);
			customerContact.setCreateDate(new Date());
			customerContact.setName(contact.getTxtName());
			customerContact.setMobile(contact.getTxtMobile());
			customerContact.setEmail(contact.getTxtEmail());
			customerContact.setAddress(contact.getTxtAddress());
			customerContact.setMessage(contact.getTxtMessage());
			
			customerContactService.saveOrUpdate(customerContact);
			jsonResult.put("message", "Cảm ơn " + contact.getTxtName() + " đã gửi thông tin phản hồi");
			
			//Xóa
			customerContact = new CustomerContact();
		}
		
		return ResponseEntity.ok(jsonResult);
	
	}
	
//	// 1 method action de gửi giữ liệu từ form --> POST
//	@RequestMapping(value = "/contact-send", method = RequestMethod.POST)
//	public String contactSend(final Model model, final HttpServletRequest request, final HttpServletResponse response)
//			throws IOException {
//		
//		Contact contact = new Contact();
//		contact.setTxtName(request.getParameter("txtName")); //Name của input
//		System.out.println("Name: " + contact.getTxtName());
//		return "frontend/contact/contact";
//	}
	
//	@RequestMapping(value = "/contact-edit", method = RequestMethod.GET)
//	public String contactEdit(final Model model, final HttpServletRequest request, final HttpServletResponse response)
//			throws IOException {
//		
//		Contact contact = new Contact("Tiểu Vũ", "vutieu@gmail.com", "0987654321", "Tiên Thiên Giới", "Chuyển kiếp cấp độ Kim tiên");
//		model.addAttribute("contact", contact);
//		return "frontend/contact/contact-edit";
//	}
	
//	@RequestMapping(value = "/contact-edit-save", method = RequestMethod.POST)
//	public ResponseEntity<Map<String, Object>> contactEditSave(final Model model, 
//			final HttpServletRequest request, 
//			final HttpServletResponse response,
//			@RequestBody Contact contact)
//			throws IOException {
//		System.out.println(contact.getTxtName());
//		//Sau khi lưu giữ liệu vào DB;
//		Map<String, Object> jsonResult = new HashMap<String, Object>(); // Gửi trở lại view
//		jsonResult.put("code", 200);
//		jsonResult.put("message", "Cảm ơn " + contact.getTxtName() + " đã gửi thông tin phản hồi");
//		return ResponseEntity.ok(jsonResult);
//	
//	}
//	
//	@RequestMapping(value = "/contact-sf", method = RequestMethod.GET)
//	public String contactSf(final Model model, 
//			final HttpServletRequest request, 
//			final HttpServletResponse response)
//			throws IOException {
//		
//		model.addAttribute("contact", new Contact());
//	
//		return "frontend/contact/contact-sf";
//	}
//	
//	@RequestMapping(value = "/contact-sf-save", method = RequestMethod.POST)
//	public String contactSfSave(final Model model, 
//			final HttpServletRequest request, 
//			final HttpServletResponse response,
//			@ModelAttribute("contact") Contact contact, //Get data from
//			@RequestParam("contactFile") MultipartFile contactFile
//			)
//			throws IOException {
//		
//		System.out.println(contact.getTxtName());
//		System.out.println(contact.getTxtMobile());
//		//Luu file vao thu muc, luong duong dan vao DB
//		//Kiem tra nguoi dung up load file khong
//		if (contactFile != null && !contactFile.getOriginalFilename().isEmpty()) {
//			String path = FOLDER_UPLOAD + "Contacts\\" + 
//								contactFile.getOriginalFilename();
//			File file = new File(path);
//			contactFile.transferTo(file);
//		}
//		return "frontend/contact/contact-sf";
//		
//	}
//	
//	@RequestMapping(value = "/contact-sf-edit", method = RequestMethod.GET)
//	public String contactSfEdit(final Model model, 
//			final HttpServletRequest request, 
//			final HttpServletResponse response)
//			throws IOException {
//		Contact contact = new Contact("Tieu Vu", "vutieu@gmail.com", "0987654321", "Thien Gioi", "Chuyen kiep cap do Kim tien");
//		model.addAttribute("contact", contact);
//		return "frontend/contact/contact-sf-edit";
//	}
	
}
