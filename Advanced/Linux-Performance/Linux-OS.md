# Tìm hiểu hệ điều hành Linux.

Tìm hiểu cách hệ thống đặt lịch, triển khai, chạy các ứng dụng và cách sử dụng tài nguyên khác như phần cứng của hệ điều hành Linux để từ đó tối ưu hiệu năng của hệ thống.

![](https://i.imgur.com/3QHOl5g.png)

## 1.1. Linux process management (Trình quản lý tiến trình của Linux)
Process management là một trong những vai trò quan trọng nhất trong bất kì hệ điều hành nào. Một process management hiệu quả cho phép các ứng dụng có thể hoạt động một cách đều đặn và hiệu quả.
Process management của Linux bao gồm việc lên lịch cho tiến trình, xử lý gián đoạn, báo hiệu, quản lý ưu tiên cho các tiến trình, trạng thái tiến trình, bộ nhớ tiến trình,...
Trong phần này sẽ mô tả cách mà Linux Kernel làm việc với tiến trình sẽ ảnh hưởng đến hiệu năng của hệ thống.

### 1.1.1. Process là gì?
Process (tiến trình) là một thể hiện của một sự thực thi mà chạy trên một processor(bộ xử lý), Process sử dụng bất cứ tài nguyên nào mà Linux kernel có thể xử lý để hoàn thành nhiệm vụ của nó.

Tất cả các tiến trình chạy trên hệ điều hành Linux được quản lý bởi kiến trúc **task_struct**, còn được gọi là process descriptor. Một process descriptor chứa tất cả những thông tin quan trọng cho một tiến trình để có thể chạy, như là thông tin nhận dạng của tiến trình, các thuộc tính của tiến trình, và các tài nguyên mà xây dựng nên tiến trình.
![](https://i.imgur.com/iu0IlNH.png)

### 1.2. Vòng đời của tiến trình.

Mọi tiến trình đều có vòng đời của nó như tạo, thực thi, chấm dứt và gỡ bỏ. Các giai đoạn như thế này thực tế lặp đi lặp lại hàng triệu lần miễn là hệ thống vẫn đang hoạt động. Vì thế mà vòng đời của tiến trình cũng rất quan trọng từ quan điểm về hiệu xuất.
![](https://i.imgur.com/XPfEHOU.png)

Khi một tiến trình tạo một tiến trình mới, tiến trình tạo(parent process) đưa ra một system call **fork()**. Khi system call **fork()** được gọi, nó sẽ lấy process descriptor của tiến trình mới được tạo và thiết lập một process id mới. Nó sao chép giá trị của process descriptor của tiến trình tạo(parent process) cho tiến trình được tạo(child process). Tại thời điểm này toàn bộ address space của tiến trình tạo không được copy mà các tiến trình này chia sẻ address space với nhau. 
System call **exec()** sao chép chương trình mới đến address space của tiến trình con. Vì tiến trình cha mẹ và tiến trình con hiện tại dùng chung address space, viết đè chương trình mới sẽ gây ra lỗi trên page. Tại thời điểm này, kernel chỉ định page vật lý mới cho tiến trình con. 
Hoạt động này được gọi là *Copy On Write*. Tiến trình con thường thực thi chương trình riêng của nó thay vì thực thi giống tiến trình cha mẹ. Hoạt động này giúp tránh những chi phí không cần thiết vì việc sao chép toàn bộ address space là rất chậm, kém hiệu quả và sử dụng nhiều thời gian xử lý và tài nguyên.
