package carashop.controller.frontend;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import carashop.controller.BaseController;

@Controller
public class BlogController extends BaseController {
	@RequestMapping(value = "/blog", method = RequestMethod.GET)
	
	public String index(final Model model,
			final HttpServletRequest request,
			final HttpServletResponse response) throws IOException {
		
		return "frontend/blog";
	}
}
