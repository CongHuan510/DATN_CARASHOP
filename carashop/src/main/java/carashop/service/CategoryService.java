package carashop.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import carashop.dto.SearchModel;
import carashop.model.Category;

@Service
public class CategoryService extends BaseService<Category> {
	@Override
	public Class<Category> clazz() {
		return Category.class;
	}

	public List<Category> findAllActive() {
		return super.executeNativeSql("SELECT * FROM tbl_category WHERE status = 'ACTIVE'");
	}

	@Transactional
	public void deleteCategoryById(int id) {
		super.deleteById(id);
	}

	@Transactional
	public void inactiveCategory(Category category) {
		super.saveOrUpdate(category);
	}

	// -----------------------------searchCategory----------------------------
	public List<Category> searchCategory(SearchModel categorySearch) {
		// Tao cau lenh sql;
		String sql = "SELECT * FROM tbl_category c WHERE 1=1";

		// Tim kiem voi status
		if (!"ALL".equals(categorySearch.getStatus())) { // Có chọn Active/Inactive
			String status = categorySearch.getStatus();
			sql += " AND c.status = '" + status + "'";
		}

		// Tim kiem voi keyword
		if (!StringUtils.isEmpty(categorySearch.getKeyword())) {
			String keyword = categorySearch.getKeyword().toLowerCase();

			sql += " AND (LOWER(c.name) like '%" + keyword + "%'" + " OR LOWER(c.description) like '%" + keyword + "%'"
					+ " OR LOWER(c.seo) like '%" + keyword + "%')";
		}

		// Tim kiem voi ngay thang
		if (!StringUtils.isEmpty(categorySearch.getBeginDate()) && !StringUtils.isEmpty(categorySearch.getEndDate())) {
			String beginDate = categorySearch.getBeginDate();
			String endDate = categorySearch.getEndDate();

			sql += " AND c.create_date BETWEEN '" + beginDate + "' AND '" + endDate + "'";
		}
		
		sql += " ORDER BY c.create_date DESC";
		return super.executeNativeSql(sql);
	}
}
