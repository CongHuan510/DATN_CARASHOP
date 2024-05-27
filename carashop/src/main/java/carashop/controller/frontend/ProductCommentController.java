package carashop.controller.frontend;

import java.io.IOException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import carashop.controller.BaseController;
import carashop.dto.EnumStatus;
import carashop.dto.Jw27Constants;
import carashop.dto.SearchModel;
import carashop.model.Category;
import carashop.model.Product;
import carashop.model.ProductComment;
import carashop.model.ProductImage;
import carashop.model.User;
import carashop.service.ProductCommentService;
import carashop.service.ProductService;
import carashop.service.ProductImageService;
import carashop.service.SaleOrderProductService;

@Controller
public class ProductCommentController extends BaseController implements Jw27Constants {

	@Autowired
	private ProductService productService;
	
	@Autowired
	private SaleOrderProductService saleOrderProductService;
	
	@Autowired
	private ProductImageService product_imageService;

	@Autowired
	private ProductCommentService productCommentService;

	@RequestMapping(value = "/product-detail/{productId}", method = RequestMethod.GET)
	public String productDetail(Model model, HttpServletRequest request, HttpServletResponse response,
			@PathVariable("productId") int productId) throws IOException {

		// Retrieve product details
		Product product = productService.getById(productId);
		model.addAttribute("inventoryQuantity", product.getProductQuantity());
		model.addAttribute("product", product);

		// Retrieve category details
		Category category = product.getCategory();
		if (category != null) {
			model.addAttribute("categoryName", category.getName());
			model.addAttribute("categoryId", category.getId());
		}

		// Truy xuất hình ảnh sản phẩm từ DB tb_product_image
		List<ProductImage> productImages = product_imageService.getProductImagesByProductIdImages(productId);
		model.addAttribute("productImages", productImages);

		// Truy xuất kích thước có sẵn cho sản phẩm
		List<String> sizes = productService.getSizesForProduct(productId);
		model.addAttribute("sizes", sizes);

		// Hiển thị các sản phẩm
		List<Product> products = productService.findAllProductByCategory(category.getId(), productId);
		model.addAttribute("products", products);
		
		List<BigDecimal> discounts = calculateDiscounts(products);
		model.addAttribute("discounts", discounts);

		// Tính số sao sản phẩm
		double aveRating = productCommentService.CalAverageByProductId(productId);
		model.addAttribute("aveRating", aveRating);

		SearchModel commentSearch = new SearchModel();

		String keyword = request.getParameter("keyword");
		if (!StringUtils.isEmpty(keyword)) {
			commentSearch.setKeyword(keyword);
			List<Product> allProducts = productService.searchListProduct(commentSearch);
			model.addAttribute("productSearch", commentSearch);
			model.addAttribute("keyword", keyword);
			model.addAttribute("allProducts", allProducts);
			return "redirect:/product?keyword=" + URLEncoder.encode(keyword, StandardCharsets.UTF_8);
		}

		// Bat dau phan trang
		if (!StringUtils.isEmpty(request.getParameter("currentPage"))) { // Bam nut chuyen trang
			commentSearch.setCurrentPage(Integer.parseInt(request.getParameter("currentPage")));
		} else {
			commentSearch.setCurrentPage(1); // lan dau truy cap luon hien thi trang 1
		}

		List<ProductComment> allComments = productCommentService.findAllReviewsByProductId(productId);
		// Sắp xếp danh sách comment theo thời gian tạo
		sortCommentsByCreateDate(allComments);
		
		
		List<ProductComment> productComments = new ArrayList<ProductComment>();

		// Tổng số trang theo tìm kiếm
		int totalPages = allComments.size() / SIZE_OF_COMMENT;
		if (allComments.size() % SIZE_OF_COMMENT > 0) {
			totalPages++;
		}

		// Nếu tổng số trang nhỏ hơn trang hiện tại
		if (totalPages < commentSearch.getCurrentPage()) {
			commentSearch.setCurrentPage(1);
		}

		// Lấy danh sách sp cần hiển thị trong 1 trang
		int firstIndex = (commentSearch.getCurrentPage() - 1) * SIZE_OF_COMMENT; // vị trí đầu 1 trang
		int index = firstIndex, count = 0;
		while (index < allComments.size() && count < SIZE_OF_COMMENT) {
			productComments.add(allComments.get(index));
			index++;
			count++;
		}

		commentSearch.setSizeOfPage(SIZE_OF_COMMENT);
		commentSearch.setTotalItems(allComments.size());

		model.addAttribute("commentSearch", commentSearch);
		model.addAttribute("totalReviews", allComments.size());
		model.addAttribute("productComments", productComments);

		// Lấy URL hiện tại và thêm tham số phân trang vào URL
		String currentUrl = request.getRequestURI();
		String paginationUrl = currentUrl + "?currentPage=";
		// Truyền URL phân trang vào model
		model.addAttribute("paginationUrl", paginationUrl);

		boolean hasPurchased = saleOrderProductService.hasPurchasedProduct(productId);
		//System.out.println(hasPurchased);
		model.addAttribute("hasPurchased", hasPurchased); 
		return "frontend/product-detail";
	}

	@RequestMapping(value = "/review-save", method = RequestMethod.POST)
	public String reviewSave(final Model model, final HttpServletRequest request, final HttpServletResponse response)
	        throws IOException {
	    
	    // Kiểm tra đăng nhập
	    Object loginedUser = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	    if (loginedUser != null && loginedUser instanceof UserDetails) {
	        User user = (User) loginedUser;

	        // Lấy id của sản phẩm hiện tại đang truy cập để comment
	        String productIdParam = request.getParameter("productId");
	        if (!StringUtils.isEmpty(productIdParam)) {
	            int productId = Integer.parseInt(productIdParam);
	            
	            // Kiểm tra xem người dùng đã mua sản phẩm này hay chưa
	            boolean hasPurchased = saleOrderProductService.hasPurchasedProduct(productId);
	            
	            if (hasPurchased) {
	                // Sản phẩm đã được mua, tiếp tục lưu bình luận và đánh giá
	               ProductComment productComment = productCommentService.findPendingReviewByUserIdAndProductId(productId, user.getId());
	               System.out.println(productComment);
	                // Lấy đánh giá từ request
	                String ratingParam = request.getParameter("rate");
	                if (!StringUtils.isEmpty(ratingParam)) {
	                    int rating = Integer.parseInt(ratingParam);
	                    productComment.setProductRating(rating);
	                }

	                // Lưu comment
	                String comment = request.getParameter("comment");
	                if (!StringUtils.isEmpty(comment)) {
	                    productComment.setComment(comment);
	                }

	                // Ngày bình luận
	                productComment.setCreateDate(new Date());
	                productComment.setStatus(EnumStatus.ACTIVE);
	                
	                // Lưu comment vào DB;
	                productCommentService.saveOrUpdate(productComment);
	                
	                // Chuyển hướng trở lại trang chi tiết sản phẩm
	                return "redirect:/product-detail/" + productIdParam;
	            } else {            
	                return null;
	            }
	        } else {
	            return null;
	        }
	    } else {
	        return "redirect:/login";
	    }
	}


	private void sortCommentsByCreateDate(List<ProductComment> comments) {
	    Collections.sort(comments, new Comparator<ProductComment>() {
	        @Override
	        public int compare(ProductComment comment1, ProductComment comment2) {
	            try {
	                return comment2.getCreateDate().compareTo(comment1.getCreateDate());
	            } catch (Exception e) {
	                // Xử lý ngoại lệ ở đây, ví dụ: in log và trả về một giá trị mặc định
	                System.err.println("Lỗi khi so sánh ngày tạo bình luận: " + e.getMessage());
	                return 0; // hoặc một giá trị mặc định khác phù hợp với nhu cầu của bạn
	            }
	        }
	    });
	}
}
