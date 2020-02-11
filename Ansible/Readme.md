# 1 bài ghi sơ sơ về ansible

Bài viết này mình chỉ viết lại cho nhớ thôi, Tham khảo từ một số nguồn: 
https://github.com/VNPT-SmartCloud-System/Tim-hieu-Ansible
https://docs.ansible.com/




[I. Tổng quan về Ansible?](#tongquan)



<a name="tongquan"></a>
## [I. Tổng quan về Ansible?](#tongquan)

**Ansible** là một công cụ mã nguồn mở được sử dụng để tự động hóa các tác vụ it như triển khai hệ thống, dịch vụ, quản lý các cài đặt, thiết lập của hệ thống hay dịch vụ, điều phối các dịch vụ nội bộ,...

Sử dụng *SSH* và các module(được viết bằng Python) để cấu hình, điều khiển hệ thống.

Sử dụng *Json* để hiển thị thông tin và sử dụng *YAML* để xây dựng mô tả cấu trúc hệ thống.

#### Đặc điểm của Ansible
- Không cần các agent chỉ cần cài lên master
- Không sử dụng các service, daemon mà chỉ thực thi khi được gọi.
- Bảo mật cao khi sử dụng SSH. Có tùy chọn sử dụng mật khẩu, tuy nhiên sử dụng SSH key là cách tốt nhất để sử dụng với Ansible.
- Sử dụng các ngôn ngữ dễ đọc, dễ hiểu và dễ viết.

#### Kiến trúc Ansible.

![](https://i.imgur.com/tAM7eIB.png)

- **Modules** - Modules là các chương trình nhỏ được viết bằng Python, được Ansible gửi đến server để thực hiện các yêu cầu mong muốn trên server. Ví dụ như module **yum**, được Ansible gửi đến các server, thực thi để cài đặt các gói phần mềm qua yum.
- **Plugins** Là các đoạn mã để cấu hình thêm các chức năng mở rộng cho Ansible. Có thể tự viết và thêm plugins cho Ansible để thêm các chức năng phù hợp với nhu cầu sử dụng.

- **Inventory** - Là file(INI hoặc YAML,...) dùng để biểu diễn các server mà Ansible quản lý. Thường là file /etc/ansible/hosts`

