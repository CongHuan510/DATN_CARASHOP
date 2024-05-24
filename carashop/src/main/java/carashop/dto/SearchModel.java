package carashop.dto;

public class SearchModel {

		private String status;
		private int categoryId;
		private String keyword;
		
		private String beginDate;
		private String endDate;
	

		private int sizeOfPage; //Số bản ghi hiển thị trên 1 trang
		private int currentPage; //Trang hiện tại
		private int totalItems; //Tổng số bản ghi tìm kiếm được
		private int totalPages; //Tổng số trang
		
		
		private String sortOption; // sắp xếp
		private int priceCheck;
		private String sizeCheck;
		
		public SearchModel() {
			super();
		}

		public SearchModel(String status, int categoryId, String keyword, String beginDate, String endDate, int sizeOfPage,
				int currentPage, int totalItems, int totalPages, String sortOption, int priceCheck, String sizeCheck) {
			super();
			this.status = status;
			this.categoryId = categoryId;
			this.keyword = keyword;
			this.beginDate = beginDate;
			this.endDate = endDate;
			this.sizeOfPage = sizeOfPage;
			this.currentPage = currentPage;
			this.totalItems = totalItems;
			this.totalPages = totalPages;
			this.sortOption = sortOption;
			this.priceCheck = priceCheck;
			this.sizeCheck = sizeCheck;
		}

		public String getStatus() {
			return status;
		}

		public void setStatus(String status) {
			this.status = status;
		}

		public int getCategoryId() {
			return categoryId;
		}

		public void setCategoryId(int categoryId) {
			this.categoryId = categoryId;
		}

		public String getKeyword() {
			return keyword;
		}

		public void setKeyword(String keyword) {
			this.keyword = keyword;
		}

		public String getBeginDate() {
			return beginDate;
		}

		public void setBeginDate(String beginDate) {
			this.beginDate = beginDate;
		}

		public String getEndDate() {
			return endDate;
		}

		public void setEndDate(String endDate) {
			this.endDate = endDate;
		}

		public int getSizeOfPage() {
			return sizeOfPage;
		}

		public void setSizeOfPage(int sizeOfPage) {
			this.sizeOfPage = sizeOfPage;
		}

		public int getCurrentPage() {
			return currentPage;
		}

		public void setCurrentPage(int currentPage) {
			this.currentPage = currentPage;
		}

		public int getTotalItems() {
			return totalItems;
		}

		public void setTotalItems(int totalItems) {
			this.totalItems = totalItems;
		}

		public int getTotalPages() {
			return totalPages;
		}

		public void setTotalPages(int totalPages) {
			this.totalPages = totalPages;
		}

		public String getSortOption() {
			return sortOption;
		}

		public void setSortOption(String sortOption) {
			this.sortOption = sortOption;
		}

		public int getPriceCheck() {
			return priceCheck;
		}

		public void setPriceCheck(int priceCheck) {
			this.priceCheck = priceCheck;
		}

		public String getSizeCheck() {
			return sizeCheck;
		}

		public void setSizeCheck(String sizeCheck) {
			this.sizeCheck = sizeCheck;
		}	
}
