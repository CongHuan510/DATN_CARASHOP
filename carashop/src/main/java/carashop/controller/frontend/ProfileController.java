package carashop.controller.frontend;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import carashop.controller.BaseController;
import carashop.model.User;
import carashop.service.UserService;

@Controller
public class ProfileController extends BaseController {

	@Autowired
	private UserService userService;

	@RequestMapping(value = "/profile", method = RequestMethod.GET)
	public String profile(final Model model,
			HttpSession session) throws IOException {

		// Lấy user theo id từ Spring security
		Object loginedUser = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if (loginedUser != null && loginedUser instanceof UserDetails) {
			User user = (User) loginedUser;
				int userId = user.getId();
				// Sử dụng ID để lấy thông tin người dùng từ cơ sở dữ liệu
				User currentUser = userService.getById(userId);
				model.addAttribute("currentUser", currentUser);
			}
		
		String message = (String) session.getAttribute("message");
	    // Xóa thông báo khỏi session
	    session.removeAttribute("message");
	    // Truyền thông báo đến model
	    model.addAttribute("message", message);
		return "frontend/profile";
	}

	// SAVE EDIT PROFILE
	@RequestMapping(value = "/profile/edit-save", method = RequestMethod.POST)
	// Cách đẩy 1 dữ liệu sang view
	public String editSave(final Model model, @ModelAttribute("currentUser") User currentUser,
			@RequestParam("avatarFile") MultipartFile avatarFile
			, HttpSession session) throws IOException {
		
		userService.saveProfile(currentUser, avatarFile);
		session.setAttribute("message", "Cập nhật thông tin cá nhân thành công!");
		 return "redirect:/profile";
	}
}
