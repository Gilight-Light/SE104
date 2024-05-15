$(document).ready(function () {
    const table = $('#datatablesSimple'); // Thay thế bằng ID của bảng của bạn
    const rowsPerPage = 10; // Số lượng hàng tối đa hiển thị mỗi trang
  
    // Lấy tổng số hàng trong bảng
    const totalRows = table.find('tr').length - 1; // Trừ 1 để loại trừ hàng tiêu đề
  
    // Khởi tạo điều khiển phân trang
    const pageCount = Math.ceil(totalRows / rowsPerPage); // Tính toán tổng số trang
    const datatableBottom = $('<div class="datatable-bottom"></div>');
    const navPagination = $('<nav class="datatable-pagination"></nav>');
    datatableBottom.append(navPagination);
    const paginationControls = $('<ul class="datatable-pagination-list"></ul>');
    for (let i = 1; i <= pageCount; i++) {
      const pageLink = $('<li><a href="#">' + i + '</a></li>');
      pageLink.click(function (event) {
        event.preventDefault();
        showPage(i);
      });
      paginationControls.append(pageLink);
    }
    navPagination.append(paginationControls);
    table.after(datatableBottom);
  
    // Hiển thị trang đầu tiên mặc định
    showPage(1);
  
    function showPage(pageNumber) {
      // Tạo bản sao của phần tử 'thead'
      const theadClone = table.find('thead').clone();
  
      // Ẩn tất cả các hàng trong bảng
      table.find('tr').hide();
  
      // Hiển thị chỉ các hàng cho trang hiện tại
      const startRow = (pageNumber - 1) * rowsPerPage;
      const endRow = startRow + rowsPerPage;
      for (let i = startRow + 1; i <= endRow; i++) {
        table.find('tr:nth-child(' + i + ')').show();
      }
  
      // Thêm bản sao 'thead' vào đầu bảng
      table.find('thead').remove();
      table.prepend(theadClone);
  
      // Cập nhật liên kết trang đang hoạt động
      paginationControls.find('li').removeClass('active');
      paginationControls.find('li:nth-child(' + pageNumber + ')').addClass('active');
    }
  });
  
  $(document).ready(function () {
    const table = $('#datatablesStatistical'); // Thay thế bằng ID của bảng của bạn
    const rowsPerPage = 10; // Số lượng hàng tối đa hiển thị mỗi trang
  
    // Lấy tổng số hàng trong bảng
    const totalRows = table.find('tr').length - 1; // Trừ 1 để loại trừ hàng tiêu đề
  
    // Khởi tạo điều khiển phân trang
    const pageCount = Math.ceil(totalRows / rowsPerPage); // Tính toán tổng số trang
    const datatableBottom = $('<div class="datatable-bottom"></div>');
    const navPagination = $('<nav class="datatable-pagination"></nav>');
    datatableBottom.append(navPagination);
    const paginationControls = $('<ul class="datatable-pagination-list"></ul>');
    for (let i = 1; i <= pageCount; i++) {
      const pageLink = $('<li><a href="#">' + i + '</a></li>');
      pageLink.click(function (event) {
        event.preventDefault();
        showPage(i);
      });
      paginationControls.append(pageLink);
    }
    navPagination.append(paginationControls);
    table.after(datatableBottom);
  
    // Hiển thị trang đầu tiên mặc định
    showPage(1);
  
    function showPage(pageNumber) {
      // Tạo bản sao của phần tử 'thead'
      const theadClone = table.find('thead').clone();
  
      // Ẩn tất cả các hàng trong bảng
      table.find('tr').hide();
  
      // Hiển thị chỉ các hàng cho trang hiện tại
      const startRow = (pageNumber - 1) * rowsPerPage;
      const endRow = startRow + rowsPerPage;
      for (let i = startRow + 1; i <= endRow; i++) {
        table.find('tr:nth-child(' + i + ')').show();
      }
  
      // Thêm bản sao 'thead' vào đầu bảng
      table.find('thead').remove();
      table.prepend(theadClone);
  
      // Cập nhật liên kết trang đang hoạt động
      paginationControls.find('li').removeClass('active');
      paginationControls.find('li:nth-child(' + pageNumber + ')').addClass('active');
    }
  });
  
  