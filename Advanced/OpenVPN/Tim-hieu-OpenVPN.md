# Một số ghi chép

## 1. Kết nối 
- Server sẽ lắng nghe trên port 1194 mặc định, client sẽ kết nối đến server thông qua port này,
- 2 loại thiết bị mạng là tun và tap
- Khi client khởi tạo bắt tay với server, tun hoặc tap interface
## 2. OpenVPN secret keys.
- Openvpn sử dụng những key bí mật để mã hóa lưu lượng giữa client và server trong VPN.
- Mặc định OpenVPN sẽ sử dụng 2 key đối xứng khi thiết lập kết nốib point to point.
  - Một key mật mã để mã hóa nội dung gói tin được gửi.
  - Một key HMAC để ký gói tin. Khi mà gói tin di chuyển mà không được ký bởi key HMAC thích hợp sẽ bị drop ngay lập tức. Đấy như là tuyến phòng thủ đầu tiên chống lại cuộc tấn công DOS.
- Một bộ key sẽ cùng được sử dụng bởi cả hai đầu, và hai khóa trong bộ đều có nguồn gốc từ một file mà được chỉ định bởi tham số `--secret`.
- File key bí mật của OpenVPN sẽ có format như sau:
```
An OpenVPN secret key file is formatted as follows:
#
# 2048 bit OpenVPN static key
#
-----BEGIN OpenVPN Static key V1-----
<16 dòng chứa các byte ngẫu nhiên>
-----END OpenVPN Static key V1-----
```
- Từ 16 dòng chứa các byte ngẫu nhiên sẽ key mật mã và key HMAC được tạo ra. Key này giống nhau cho mỗi session.

## 3. Multiple secret keys
- Ngoài sử dụng cặp key đối xứng, OpenVPN cũng có thể sử dụng các key không đối xứng, được chia sẻ. Nó sẽ sử dụng 4 key trong trường hợp này:
  - Key mật mã(Cipher key) trên client
  - Key HMAC trên phía client
  - Key mật mã trên server
  - Key HMAC trên server.
- Một vật liệu chung để tạo key được chia sẻ cho hai bên trong kết nối point to point tuy nhiên những key được tạo ra để mã hóa và ký thì khác nhau trên mỗi bên.

- OpenVPN lấy tất cả các keys từ file `static.key` mà nó có đủ sự ngẫu nhiên trong file để tạo ra được 4 key một cách đáng tin cậy.
- Một file key tĩnh của OpenVPN có kích thước 2048 bit. Mỗi Cipher key là 128 bit, mỗi HMAC key là 160 bit. Do đó nó có thể dễ dàng tạo 4 keys từ file key tĩnh