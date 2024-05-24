package carashop.controller;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.ModelAttribute;

import carashop.dto.Cart;
import carashop.model.Category;
import carashop.model.Product;
import carashop.model.ProductComment;
import carashop.model.User;
import carashop.service.CategoryService;
import carashop.service.FavoriteProductService;
import carashop.service.ProductCommentService;
import carashop.service.ProductService;

@Configuration
public class BaseController {
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired 
	private FavoriteProductService favoriteProductService;
	
	@Autowired
	private ProductCommentService productCommentService;
	@ModelAttribute("title")
	public String projectTitle() {
		return "Cara Shop";
	}

	@ModelAttribute("totalCartProducts")
	public BigInteger getTotalCartProducts(final HttpServletRequest request) {
		HttpSession session = request.getSession();
		if (session.getAttribute("cart") == null) {
			return BigInteger.ZERO;
		}
		Cart cart = (Cart) session.getAttribute("cart");
		return cart.totalCartProduct();
	}
	
	// Viết modelAttribute("totalFavoriteProducts") để cho hiển thị được tất cả các trang khi url
	@ModelAttribute("totalFavoriteProducts")
	public int getTotalFavoriteProducts() {
	    // Lấy thông tin người dùng hiện tại từ Spring Security
		Object loginedUser = SecurityContextHolder.getContext()
				.getAuthentication().getPrincipal();

		if (loginedUser != null && loginedUser instanceof UserDetails) {
	        // Nếu người dùng đã đăng nhập, lấy thông tin user_id
			User user = (User) loginedUser;
	        int userId = user.getId();
	        // Đếm số lượng sản phẩm yêu thích của người dùng từ cơ sở dữ liệu
	        int totalFavoriteProducts = favoriteProductService.countTotalFavoriteProductsByUserId(userId);	      
	        // Trả về số lượng sản phẩm yêu thích
	        return totalFavoriteProducts;
	    } else {
	        // Nếu người dùng chưa đăng nhập, trả về 0
	        return 0;
	    }
	}
	
	@ModelAttribute("totalReviewsMap")	
	public Map<Integer, Integer> getTotalReviewsProduct() {
		Map<Integer, Integer> totalReviewsMap = new HashMap<>();
		
	    List<Product> products = productService.findAllActive();
	    for (Product product : products) {
	        List<ProductComment> allComments = productCommentService.findAllReviewsByProductId(product.getId());
	        int totalReviews = allComments.size();
	        totalReviewsMap.put(product.getId().intValue(), totalReviews);
	    }
	    return totalReviewsMap;
	}

	
	@ModelAttribute("categories")
	public List<Category> getCategory(final HttpServletRequest request) {
	     return categoryService.findAllActive();
	}
	
	// Phương thức để tính toán giá trị discount cho danh sách sản phẩm
	public List<BigDecimal> calculateDiscounts(List<Product> products) {
	    List<BigDecimal> discounts = new ArrayList<>();
	    for (Product product : products) {
	        BigDecimal discount = BigDecimal.ZERO;
	        if (product.getPrice() != null && product.getSalePrice() != null &&
	                product.getPrice().compareTo(BigDecimal.ZERO) > 0 &&
	                product.getSalePrice().compareTo(BigDecimal.ZERO) > 0) {
	            BigDecimal val = product.getPrice().subtract(product.getSalePrice()); // (78000-70000)
	            discount = val.divide(product.getPrice(), 2, RoundingMode.HALF_UP)
	                    .multiply(BigDecimal.valueOf(100));
	        }
	        discounts.add(discount);
	    }
	    return discounts;
	}

    // Tính sao trung bình chung
 // Phương thức tính toán averageRatings cho danh sách sản phẩm theo is_hot và danh sách sản phẩm active
    public Map<Integer, Double> calculateAverageRatingsForProducts(List<Product> products) {
        Map<Integer, Double> averageRatings = new HashMap<>();
        for (Product product : products) {
            double average = productCommentService.CalAverageByProductId(product.getId());
            averageRatings.put(product.getId(), average);
        }
        return averageRatings;
    }

    // @ModelAttribute cho averageRatings cho cả danh sách sản phẩm theo is_hot và danh sách sản phẩm active
    @ModelAttribute("averageRating")
    public Map<Integer, Double> getAverageRatingsForProducts() {
        List<Product> hotProducts = productService.findAllActiveAndIsHot(); // Sử dụng phương thức tương ứng để lấy danh sách sản phẩm theo is_hot
        List<Product> activeProducts = productService.findAllActive(); // Lấy danh sách tất cả sản phẩm active
        List<Product> allProducts = new ArrayList<>();
        allProducts.addAll(hotProducts);
        allProducts.addAll(activeProducts);
        return calculateAverageRatingsForProducts(allProducts);
    }
    			
	@ModelAttribute("cart")
	public Cart getCart(final HttpServletRequest request) {
	    HttpSession session = request.getSession();
	    Cart cart = (Cart) session.getAttribute("cart");
	    if (cart == null) {
	        cart = new Cart();
	        session.setAttribute("cart", cart);
	    }
	    // Lưu totalCartPrice vào session để sử dụng trong các trang JSP
	    session.setAttribute("totalCartPrice", cart.totalCartPrice());
	    return cart;
	}

	
	// Lay thong tin cua user dang nhap
	@ModelAttribute("loginedUser")
	public User getLoginedUser() {

		Object loginedUser = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		if (loginedUser != null && loginedUser instanceof UserDetails) {
			User user = (User) loginedUser;
			return user;
		}
		return new User();
	}
	

	// Kiem tra da login hay chua
	@ModelAttribute("isLogined")
	public boolean isLogined() {

		Object loginedUser = SecurityContextHolder.getContext()
				.getAuthentication().getPrincipal();

		if (loginedUser != null && loginedUser instanceof UserDetails) {

			return true;
		}
		return false;
	}	
	
	@ModelAttribute("SuperAdmin")
    public boolean isSuperAdmin() {
        // Lấy thông tin người dùng hiện tại từ Spring Security
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication != null && authentication.isAuthenticated()) {
            // Kiểm tra xem người dùng có thuộc quyền SuperAdmin hay không
            for (GrantedAuthority authority : authentication.getAuthorities()) {
                if (authority.getAuthority().equals("SUPERADMIN")) {
                    return true;
                }
            }
        }

        return false;
    }
}
