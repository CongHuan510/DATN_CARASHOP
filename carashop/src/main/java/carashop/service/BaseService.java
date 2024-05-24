package carashop.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.Table;
import javax.transaction.Transactional;

import carashop.model.BaseModel;

public abstract class BaseService<E extends BaseModel> { // mỗi 1 service làm việc với 1 model

	// Khai báo đối tượng quản lý thao tác dịch vụ quản lý thực thể
	@PersistenceContext
	EntityManager entityManager; // interface

	public abstract Class<E> clazz(); // Phương thức trừu tượng trả về 1 class

	// Lấy 1 bản ghi theo id trả về 1 đối tượng thuộc class E
	public E getById(int id) {
		return entityManager.find(clazz(), id);
	}
	
	
	
	// Lấy tất cả các bản ghi trong một table
	@SuppressWarnings("unchecked") // bỏ đi cảnh báo từ databasse(YES/NO)
	public List<E> findAll() {
		Table table = clazz().getAnnotation(Table.class);
		return (List<E>) entityManager.createNativeQuery("SELECT * FROM " + table.name(), clazz()).getResultList();
	}

	// Thêm mới hoặc sửa một bản ghi
	@Transactional
	public E saveOrUpdate(E entity) {
		if (entity.getId() == null || entity.getId() <= 0) { // add new entity
			entityManager.persist(entity);
			return entity;
		} else { // update entity
			return entityManager.merge(entity);
		}
	}

	// Xóa 1 bản ghi theo entity
	public void delete(E entity) {
		entityManager.remove(entity);
	}

	// Xóa theo id
	public void deleteById(int id) {
		E entity = this.getById(id);
		delete(entity);
	}

	@SuppressWarnings("unchecked")
	public List<E> executeNativeSql(String sql) { //
		try {
			Query query = entityManager.createNativeQuery(sql, clazz());
			return query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	// search and paging
	// Get entity
	public E getEntityByNativeSQL(String sql) {
		List<E> list = executeNativeSql(sql);
		if (list.size() > 0) {
			return list.get(0);
		} else {
			return null;
		}
	}
}
