Chat App - Flutter & Firebase
Ứng dụng nhắn tin thời gian thực được xây dựng bằng Flutter theo kiến trúc Clean Architecture và quản lý trạng thái bằng BLoC/Cubit.

🚀 Tính năng chính
Xác thực người dùng: Đăng ký, đăng nhập và đăng xuất thông qua Firebase Authentication.

Nhắn tin thời gian thực: Gửi và nhận tin nhắn tức thì với Cloud Firestore.

Quản lý bạn bè: Tìm kiếm người dùng, gửi lời mời kết bạn và quản lý danh sách bạn bè.

Thêm bạn qua mã QR: Tích hợp tính năng quét mã QR và hiển thị mã QR cá nhân để kết bạn nhanh chóng.

Thông tin cá nhân: Cập nhật thông tin người dùng và ảnh đại diện.

Tìm kiếm: Tìm kiếm bạn bè và lịch sử tìm kiếm gần đây.

🏗️ Kiến trúc & Công nghệ
Dự án áp dụng Clean Architecture để đảm bảo tính mở rộng và dễ bảo trì, chia làm 3 lớp:

Data: Xử lý logic dữ liệu (Models, Data Sources, Repositories Implementation).

Domain: Chứa logic nghiệp vụ (Entities, Repositories Interfaces, Usecases).

Presentation: Giao diện người dùng và quản lý trạng thái (Screens, Widgets, BLoC/Cubit).

Các thư viện chính:

Quản lý trạng thái: flutter_bloc

Điều hướng: go_router

Backend: firebase_core, cloud_firestore, firebase_auth

Dependency Injection: get_it

Tiện ích: qr_flutter, mobile_scanner, equatable, cached_network_image
