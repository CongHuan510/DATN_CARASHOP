package carashop.controller.frontend;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import carashop.controller.BaseController;
import carashop.model.FavoriteProduct;
import carashop.model.Product;
import carashop.model.User;
import carashop.service.FavoriteProductService;
import carashop.service.ProductService;

@Controller
public class FavoriteController extends BaseController {

	@Autowired
	private FavoriteProductService favoriteProductService;

	@Autowired
	private ProductService productService;
	
	@RequestMapping(value = "/favorite", method = RequestMethod.GET)
	public String cartView(final Model model, final HttpServletRequest request) throws IOException {
	    // Lấy thông tin người dùng đang đăng nhập
		Object loginedUser = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		if (loginedUser != null && loginedUser instanceof UserDetails) {
			User user = (User) loginedUser;

	        // Lấy danh sách các sản phẩm yêu thích của người dùng từ service
	        List<FavoriteProduct> favoriteProducts = favoriteProductService.getFavoriteProductsByUserId(user.getId());
	        
	        // Tính toán giá discount cho các sản phẩm yêu thích
	        List<BigDecimal> discounts = new ArrayList<>();
	        for (FavoriteProduct favoriteProduct : favoriteProducts) {
	            Product product = favoriteProduct.getProduct();
	            BigDecimal discount = BigDecimal.ZERO;
	            if (product.getPrice() != null && product.getSalePrice() != null &&
	                    product.getPrice().compareTo(BigDecimal.ZERO) > 0 &&
	                    product.getSalePrice().compareTo(BigDecimal.ZERO) > 0) {
	                BigDecimal val = product.getPrice().subtract(product.getSalePrice());
	                discount = val.divide(product.getPrice(), 2, RoundingMode.HALF_UP)
	                        .multiply(BigDecimal.valueOf(100));
	            }
	            discounts.add(discount);
	        }
	        model.addAttribute("discounts", discounts);
	        model.addAttribute("favoriteProducts", favoriteProducts); 
	        String errorMessage = "Bạn chưa có sản phẩm yêu thích nào!";
	        model.addAttribute("errorMessage", errorMessage);
	    } else {
	    	String errorMessage = "Bạn chưa có sản phẩm yêu thích nào!";
	        model.addAttribute("errorMessage", errorMessage);
	    }
		
	    return "frontend/favorite";
	}

	// Thêm sản phẩm yêu thích
	@RequestMapping(value = "/add-to-favorite/{productId}", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addToFavorite(@PathVariable int productId) {
	    Map<String, Object> jsonResult = new HashMap<>();

	    // Kiểm tra người dùng đã đăng nhập chưa
	    Object loginedUser = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	    if (loginedUser != null && loginedUser instanceof UserDetails) {
	        User user = (User) loginedUser;
	        // Lưu thông tin sản phẩm vào danh sách yêu thích
	        FavoriteProduct favoriteProduct = new FavoriteProduct();
	        favoriteProduct.setUser(user);
	        int userId = user.getId();

	        // Kiểm tra sự tồn tại của sản phẩm trong danh sách yêu thích của người dùng
	        boolean isProductInFavorites = favoriteProductService.isProductInFavorites(productId, userId);
	        if (!isProductInFavorites) {
	            // Lấy đối tượng sản phẩm từ cơ sở dữ liệu
	            Product dbProduct = productService.getById(productId);
	            favoriteProduct.setProduct(dbProduct);
	            favoriteProductService.saveOrUpdate(favoriteProduct);

	            // Thiết lập kết quả thành công
	            jsonResult.put("code", 200);
	            jsonResult.put("totalFavoriteProducts", favoriteProductService.countTotalFavoriteProductsByUserId(userId));
	            jsonResult.put("message", "Đã thêm sản phẩm " + favoriteProduct.getProduct().getName() + " vào danh sách yêu thích thành công!");
	        } else {
	            // Trả về thông báo lỗi khi sản phẩm đã tồn tại trong danh sách yêu thích của người dùng
	            jsonResult.put("errorMessage", "Sản phẩm này đã được thêm vào danh sách yêu thích!");
	        }
	    } else {
	        // Trả về thông báo lỗi khi người dùng chưa đăng nhập
	        jsonResult.put("errorMessage", "Vui lòng đăng nhập để thêm sản phẩm vào danh sách yêu thích!");
	    }

	    return ResponseEntity.ok(jsonResult);
	}


	//Xóa sản phẩm yêu thích
	// Xóa sản phẩm yêu thích
	@RequestMapping(value = "/remove-from-favorite/{productId}", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> removeFromFavorite(@PathVariable int productId) {
		Map<String, Object> jsonResult = new HashMap<String, Object>();
		Object loginedUser = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		if (loginedUser != null && loginedUser instanceof UserDetails) {
			User user = (User) loginedUser;
	        int userId = user.getId();
	        // Lấy đối tượng sản phẩm yêu thích từ cơ sở dữ liệu
	        FavoriteProduct favoriteProduct = favoriteProductService.getByProductId(productId);

	        // Xóa sản phẩm yêu thích khỏi danh sách
	        favoriteProductService.deleteFavoriteProductById(favoriteProduct.getId());
	        // Đếm số lượng sản phẩm yêu thích sau khi xóa
	        
	        int totalFavoriteProducts = favoriteProductService.countTotalFavoriteProductsByUserId(userId);
	        // Thiết lập kết quả thành công
	        jsonResult.put("code", 200);
	        jsonResult.put("totalFavoriteProducts", totalFavoriteProducts);
	        jsonResult.put("message", "Đã xóa sản phẩm " + favoriteProduct.getProduct().getName() + " khỏi danh sách yêu thích!");    
	    } 
	    return ResponseEntity.ok(jsonResult);
	}
}
