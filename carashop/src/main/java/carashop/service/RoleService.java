package carashop.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import carashop.dto.SearchModel;
import carashop.model.Role;

@Service
public class RoleService extends BaseService<Role> {
	@Override
	public Class<Role> clazz() {
		return Role.class;
	}

	public List<Role> findAllActive() {
		return super.executeNativeSql("SELECT * FROM tbl_role WHERE status = 'ACTIVE'");
	}

	@Transactional
	public void deleteRoleById(int id) {
		super.deleteById(id);
	}

	@Transactional
	public void inactiveRole(Role role) {
		super.saveOrUpdate(role);
	}

	public Role getRoleByName(String roleName) {
		String sql = "SELECT * FROM tbl_role WHERE name = '" + roleName + "'";
		List<Role> roles = super.executeNativeSql(sql);
		if (roles.size() > 0) {
			return roles.get(0);
		} else {
			return new Role();
		}
	}

	public Role getRoleById(int roleId) {
		String sql = "SELECT * FROM tbl_role WHERE id = '" + roleId + "'";
		List<Role> roles = super.executeNativeSql(sql);
		if (roles.size() > 0) {
			return roles.get(0);
		} else {
			return new Role();
		}
	}

	// -----------------------------searchCategory----------------------------
	public List<Role> searchRole(SearchModel roleSearch) {
		// Tao cau lenh sql;
		String sql = "SELECT * FROM tbl_role r WHERE 1=1";

		// Tim kiem voi status
		if (!"ALL".equals(roleSearch.getStatus())) { // Có chọn Active/Inactive
			String status = roleSearch.getStatus();
			sql += " AND r.status = '" + status + "'";
		}

		// Tim kiem voi keyword
		if (!StringUtils.isEmpty(roleSearch.getKeyword())) {
			String keyword = roleSearch.getKeyword().toLowerCase();

			sql += " AND (LOWER(r.name) like '%" + keyword + "%'" + " OR LOWER(r.description) like '%" + keyword
					+ "%')";
		}

		// Tim kiem voi ngay thang
		if (!StringUtils.isEmpty(roleSearch.getBeginDate()) && !StringUtils.isEmpty(roleSearch.getEndDate())) {
			String beginDate = roleSearch.getBeginDate();
			String endDate = roleSearch.getEndDate();

			sql += " AND r.create_date BETWEEN '" + beginDate + "' AND '" + endDate + "'";
		}
		sql += " ORDER BY r.create_date DESC";
		return super.executeNativeSql(sql);
	}
}
