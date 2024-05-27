package carashop.controller.frontend;

import java.math.BigDecimal;
import java.util.ArrayList;
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
public class ListProductController extends BaseController implements Jw27Constants {

	@Autowired
	private ProductService productService;

//	@RequestMapping(value = "/product", method = RequestMethod.GET)
//	public String list(final Model model, final HttpServletRequest request, final HttpServletResponse response) throws IOException {
//	    SearchModel searchModel = new SearchModel();
//
//	    searchModel.setCategoryId(0);
//		String categoryId = request.getParameter("categoryId");
//		if (!StringUtils.isEmpty(categoryId)) { // Neu co chon status
//			searchModel.setCategoryId(Integer.parseInt(categoryId));
//		}
////	    
//	    // Truyền danh sách danh mục sản phẩm vào model
//	    List<Category> categories = categoryService.findAll();
//	    model.addAttribute("categories", categories);
//	    
//	    List<Product> products = productService.searchProductInHome(searchModel);
//	    model.addAttribute("products", products);
//	    model.addAttribute("searchModel", searchModel);
//	    
//	    return "frontend/product";
//	} 


	@RequestMapping(value = "/product", method = RequestMethod.GET)
	public String listProduct(final Model model, final HttpServletRequest request) {
		SearchModel productSearch = new SearchModel();

		// Tim theo category
		productSearch.setCategoryId(0);
		String categoryId = request.getParameter("categoryId");
		if (!StringUtils.isEmpty(categoryId)) { // Neu co chon status
			productSearch.setCategoryId(Integer.parseInt(categoryId));
		}

		// Tim theo key
		productSearch.setKeyword(null);
		String keyword = request.getParameter("keyword");
		if (!StringUtils.isEmpty(keyword)) {
			productSearch.setKeyword(keyword);
		}
		
		// Lọc theo giá tiền
		productSearch.setPriceCheck(0);
	    String priceCheck = request.getParameter("priceCheck");
	    if (!StringUtils.isEmpty(priceCheck)) {
	    	productSearch.setPriceCheck(Integer.parseInt(priceCheck));
	    }
	    
	    //Sắp xếp theo Option
	    productSearch.setSortOption(null);
	    String sortOption = request.getParameter("sortOption");
	    if (!StringUtils.isEmpty(sortOption)) {
	    	productSearch.setSortOption(sortOption);
	    }
	    
	    // Lọc theo size
	    productSearch.setSizeCheck(null);
	    String sizeCheck = request.getParameter("sizeCheck");
	    if (!StringUtils.isEmpty(sizeCheck)) {
	    	productSearch.setSizeCheck(sizeCheck);
	    }

		// Bat dau phan trang
		if (!StringUtils.isEmpty(request.getParameter("currentPage"))) { // Bam nut chuyen trang
			productSearch.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		} else {
			productSearch.setCurrentPage(1); // lan dau truy cap luon hien thi trang 1
		}

		List<Product> allProducts = productService.searchListProduct(productSearch);// Tim kiem
		 // Tính toán lại giá trị discount cho danh sách sản phẩm mới
        List<BigDecimal> discounts = calculateDiscounts(allProducts);
		List<Product> products = new ArrayList<Product>(); // DS sp can hien thi trang hien tai

		// Tong so trang theo tim kiem
		int totalPages = allProducts.size() / SIZE_OF_PRODUCT;
		if (allProducts.size() % SIZE_OF_PRODUCT > 0) {
			totalPages++;
		}

		// Neu tong so trang < trang hien tai (lai bam tim kiem)
		if (totalPages < productSearch.getCurrentPage()) {
			productSearch.setCurrentPage(1);
		}

		// Lay danh sach sp can hien thi trong 1 trang
		int firstIndex = (productSearch.getCurrentPage() - 1) * SIZE_OF_PRODUCT; // vị trị dau 1 trang
		int index = firstIndex, count = 0;
		while (index < allProducts.size() && count < SIZE_OF_PRODUCT) {
			products.add(allProducts.get(index));
			index++;
			count++;
		}

		// Phan trang
		productSearch.setSizeOfPage(SIZE_OF_PRODUCT); // So ban ghi tren 1 trang
		productSearch.setTotalItems(allProducts.size()); // Tong so san pham theo tim kiem

		// List<Product> products = productService.productSearch(productSearch);
		model.addAttribute("products", products);
		model.addAttribute("productSearch", productSearch);	
		model.addAttribute("keyword", keyword);
		model.addAttribute("discounts", discounts);
		return "frontend/product";
	}
}
