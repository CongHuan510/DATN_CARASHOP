package carashop.controller.frontend;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import carashop.controller.BaseController;
import carashop.dto.Jw27Constants;
import carashop.dto.SearchModel;
import carashop.model.Product;
import carashop.service.ProductService;


@Controller
public class HomeController extends BaseController implements Jw27Constants {
	@Autowired
	private ProductService productService;
	
	// @RequestMapping: Ánh xạ một action đến một action method trong controller
//	@RequestMapping(value = "/index", method = RequestMethod.GET)
//	
//	public String index(final Model model,
//			final HttpServletRequest request,
//			final HttpServletResponse response) throws IOException {
//		
//		List<Product> products = productService.findAllActive();
//		model.addAttribute("products", products);
//			
//		return "frontend/index";
//	}

	@RequestMapping(value = "index", method = RequestMethod.GET)
	public String list(final Model model, final HttpServletRequest request) {

	    SearchModel productSearch = new SearchModel();

	    String keyword = request.getParameter("keyword");
	    if (!StringUtils.isEmpty(keyword)) {
	        productSearch.setKeyword(keyword);
	        List<Product> allProducts = productService.searchListProduct(productSearch);
	        model.addAttribute("productSearch", productSearch);
	        model.addAttribute("keyword", keyword);
	        model.addAttribute("allProducts", allProducts);
	        return "redirect:/product?keyword=" + URLEncoder.encode(keyword, StandardCharsets.UTF_8);
	    }
	    
	    // Lấy ra danh sách sản phẩm isHot
	    List<Product> isHotProducts = productService.findAllActiveAndIsHot();
	    model.addAttribute("isHotProducts", isHotProducts);
	    model.addAttribute("discountsForHotProducts", calculateDiscounts(isHotProducts));

	    List<Product> products = productService.findTop8ProductNew();
	    model.addAttribute("products", products);
	    model.addAttribute("discountsForAllProducts", calculateDiscounts(products));
	       

	    return "frontend/index"; // --> Browser
	}
	
}