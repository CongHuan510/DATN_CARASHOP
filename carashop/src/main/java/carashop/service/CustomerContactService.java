package carashop.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import carashop.dto.SearchModel;
import carashop.model.CustomerContact;

@Service
public class CustomerContactService extends BaseService<CustomerContact> {

	@Override
	public Class<CustomerContact> clazz() {
		return CustomerContact.class;
	}

	public List<CustomerContact> findAllActive() {
		return super.executeNativeSql("SELECT * FROM tbl_contact WHERE status= 'ACTIVE' ");
	}

	@Transactional
	public void CustomerContact(int id) {
		super.deleteById(id);
	}

	@Transactional
	public void inactiveCustomerContact(CustomerContact customerContact) {
		super.saveOrUpdate(customerContact);
	}

	// -----------------------------searchCategory----------------------------
	public List<CustomerContact> searchCustomerContact(SearchModel contactSearch) {
		// Tao cau lenh sql;
		String sql = "SELECT * FROM tbl_contact c WHERE 1=1";

		// Tim kiem voi status
		if (!"ALL".equals(contactSearch.getStatus())) { // Có chọn Active/Inactive
			String status = contactSearch.getStatus();
			sql += " AND c.status = '" + status + "'";
		}

		// Tim kiem voi keyword
		if (!StringUtils.isEmpty(contactSearch.getKeyword())) {
			String keyword = contactSearch.getKeyword().toLowerCase();

			sql += " AND (LOWER(c.name) like '%" + keyword + "%'" + " OR LOWER(c.address) like '%" + keyword + "%'"
					+ " OR LOWER(c.message) like '%" + keyword + "%')";
		}

		// Tim kiem voi ngay thang
		if (!StringUtils.isEmpty(contactSearch.getBeginDate()) && !StringUtils.isEmpty(contactSearch.getEndDate())) {
			String beginDate = contactSearch.getBeginDate();
			String endDate = contactSearch.getEndDate();

			sql += " AND c.create_date BETWEEN '" + beginDate + "' AND '" + endDate + "'";
		}
		
		sql += " ORDER BY c.create_date DESC";
		return super.executeNativeSql(sql);
	}
}
