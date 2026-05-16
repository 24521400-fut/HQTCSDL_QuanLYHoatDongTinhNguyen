ĐẶC TẢ CHI TIẾT: TRANG CHI TIẾT CHIẾN DỊCH (TNV ROLE)
1. Thành phần Giao diện & Luồng dữ liệu
1.1. Thông tin chung (Campaign Header)
Nội dung: Tên chiến dịch, địa điểm, và thời gian tổng thể.

Quy tắc: Tuân theo quy tắc thiết kế chung của hệ thống (Global Design Rules).

1.2. Thời khóa biểu nhiệm vụ (Activity Timetable)
Mô tả: Thay vì danh sách đơn thuần, các nhiệm vụ (CongViec) sẽ được trình bày dưới dạng lưới thời gian (Grid/Timetable) tương tự như lịch học sinh viên.

Dữ liệu (Table CongViec):

Trục ngang: Các ngày trong tuần/tháng của chiến dịch.

Trục dọc: Các khung giờ (Ca sáng/chiều/tối).

Ô dữ liệu: Hiển thị TenCongViec. Khi click vào ô sẽ hiện thông tin chi tiết nhiệm vụ.

1.3. Quản lý Minh chứng (Task Evidence)
Chức năng: Nút "Nộp minh chứng" xuất hiện ngay tại khu vực nhiệm vụ hoặc cuối trang chi tiết.

Hành động: Khi nhấn nút, hệ thống chuyển hướng đến trang nộp minh chứng hoặc mở Modal upload. Dữ liệu ghi vào bảng MinhChungTNV.

Ràng buộc: Xóa hoàn toàn tab "Nộp minh chứng" trên Sidebar trái của hệ thống để tập trung luồng xử lý tại đây.

1.4. Thanh tiến độ tích lũy (Cumulative Progress Bar)
Mô tả: Một thanh tiến trình trực quan báo hiệu mức độ cống hiến.

Logic xử lý:

Gọi hàm SF_TINH_TONG_GIO_TNV để lấy số giờ hiện tại trong chiến dịch này.

So sánh với các mốc giờ trong bảng ThamSo (Dựa trên hàm SF_GET_XEP_LOAI).

Hiển thị: "Bạn cần thêm X giờ nữa để đạt danh hiệu [Tên bậc tiếp theo]".

1.5. Bảng tin & Thảo luận (Communication)
Bảng tin: Hiển thị các TinTuc mới nhất thuộc MaChienDich này.

Thảo luận: Khu vực BinhLuan giữa TNV và BDH phụ trách.