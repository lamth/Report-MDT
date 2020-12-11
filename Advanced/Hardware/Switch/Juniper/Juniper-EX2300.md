# Cấu hình cơ bản cho Switch Juniper EX2300


## Nguồn tài liêu:
- Cấu hình:
https://www.juniper.net/documentation/en_US/release-independent/junos/topics/topic-map/ex2300-configuring-junos-os.html

- Thông số phần cứng:
https://www.juniper.net/documentation/en_US/release-independent/junos/topics/concept/ex2300-hardware-overview.html


- Specs:
https://www.juniper.net/assets/fr/fr/local/pdf/datasheets/1000579-en.pdf


## 1. Cấu hình mặc định

Juniper EX series có cấu hình mặc định (factory-default configuration), khi cấu hình và commit các cấu hình, cấu hình mới sẽ trở thành cấu hình hoạt động cho switch. Có thể quay trở về cấu hình mặc định theo hướng dẫn [ở đây](#default).

## 2. Kết nối và cấu hình Juniper EX(CLI)
Có thể kết nối với switch ở port **MGMT** bằng cáp RJ45 hoặc kết nối console với switch ở port **CON**.

![](https://i.imgur.com/Xp999LC.png) 



Có hai cách để cấu hình Juniper EX là cấu hình thông qua console (cli) hoặc qua J WEB (GUI). Mục này là các cấu hình thông qua giao diện dòng lệnh.

- Thông số kết nối:
    - Baud rate—9600
    - Flow control—None
    - Data—8
    - Parity—None
    - Stop bits—1
    - DCD state—Disregard
1. Kết nối thông qua cáp **RJ-45 to DB-9** và **RS232 to USB** 

![](https://i.imgur.com/mZhHcoK.png)

2. Tiến hành cấu hình cơ bản. Ở shell prompt là **root%**, gõ lệnh `ezsetup`.

3. Nhập hostname cho switch

4. Nhập password cho tài khoản root (2 lần).

5. Bật một số dịch vụ như SSH, telnet

> Tài khoản root không thể đăng nhập qua telnet nhưng có thể qua ssh.

6. Sử dụng trang Tùy chọn Quản lý để chọn kịch bản quản lý.

> Trên EX2300 và EX3400 không thể tạo VLAN mới để quản lý. Trên EX4500, EX6200, và EX8200 chỉ có cấu hình OUT-OF-BAND có sẵn.
- *Configure in-band management*: Cấu hình các network interface, uplink, management interface.
    - *Use the automatically created VLAN default for management*: tự động thêm các data interface vào Vlan mặc định. Chỉ định địa chỉ quản lý và gateway.
    - *Create a new VLAN for management*: Tạo và cấu hình các Vlan mới
- *Configure out-of-band management* - Cấu hình port quản lý. Chỉ định địa chỉ ip, gateway cho manager port để truy cập vào switch thông qua IP này

7. Cấu hình SNMP

8. Cấu hình thời gian, timezone.

9. Các cấu hình sẽ hiện ra. nhập `yes` để commit cấu hình.

10. (For EX4500 switches only) Enter the operational mode command request chassis pic-mode intraconnect to set the PIC mode to intraconnect.


Sau khi cấu hình **ezsetup** có thể đăng nhập vào switch với SSH, telnet hoặc Jweb để tiếp tục cấu hình.


## Kết nối và cấu hình Switch thông qua J-WEB.

Một số dòng sw không thể chạy thiết lập ban đầu (EZsetup) thông qua JWEB mà phải cấu hình qua console, sau đó mới có thể truy cập được J web.

Phải cấu hình EZsetup trên Jweb trong vòng 10 phút trước khi Sw tự động khởi động lại về cấu hình mặc định và làm mất kết nối với máy tính.

Thường là sẽ kết nối đến port MGMT và với địa chỉ Ip của Switch mặc định là 192.168.1.1 và máy tính đặt trong dải từ 192.168.1.2-254.

Truy cập J-WEb với địa chỉ http://192.168.1.1 trên web browser của máy tính.

## Khôi phục lại cấu hình mặc định của Switch Juniper EX

Có thể sử dụng nút **Menu** trên switch hoặc có thể sử dụng lệnh `request system zeroize` hoặc lệnh `load factory-default` trên giao diện CLI.

Đặc biệt với switch juniper ex2300 và ex3400 không có màn LCD và nút **Menu**, chúng ta sẽ phải sử dụng nút **Factory Reset/Mode** để khôi phục cấú hình mặc định.

### Khôi phục cấu hình mặc định trên Switch Juniper EX2300 bằng nút Factory Reset/Mode

Nút **Factory Reset/Mode** ở gần ngoài cùng bên phải ở mặt trước của switch.

Để khôi phục cấu hình mặc định của switch sử dụng nút Factory Reset/Mode làm các bước sau:
1. Ấn và giữ nút Factory Reset/Mode trong khoảng nhiều hơn 10 giây. Switch sẽ được chuyển về cấu hình mặc định, màn hình console hiển thị `committing factory default configuration`, đèn Led tín hiệu trên các port RJ-45 uplink và network sẽ đều sáng xanh.

2. Ấn và giữ nút Factory Reset/Mode trong khoảng nhiều hơn 10 giây thêm một lần nữa để vào chế độ **ezsetup** để tiến hành các thiết lập ban đầu, màn hình console sẽ hiển thị **committing ezsetup config**, và đèn tín hiệu trên các port uplink và network sẽ nhấp nháy xanh

2. Ấn và giữ nút Factory Reset/Mode trong khoảng nhiều hơn 10 giây thêm một lần nữa để vào chế độ **ezsetup** để tiến hành các thiết lập ban đầu. 

> Nút Factory Reset/Mode được bật mặc định và có thể tắt sử dụng dòng lệnh.

Cấu hình tắt nút Factory Reset/Mode:
1. 
```
[edit]
user@switch# set chassis config-button no-clear
```
2. 
```
[edit]
user@switch# commit
```

To enable the Factory Reset/Mode button, run the commands:
1. 
```
[edit]
user@switch# delete chassis config-button no-clear
```
2. 
```
[edit]
user@switch# commit
```


### Khôi phục cấu hình gốc sử dụng câu lệnh request system zeroize

Câu lệnh `request system zeroize` sẽ xóa tất cả thông tin cấu hình và khôi phục lại các giá trị, đồng thời hệ thống bỏ liên kết đến tất cả các file người dùng tạo ra, bao gồm file cấu hình, file log, khỏi cây thư mục của nó. Sau đó khởi động lại switch để đưa nó về cấu hình mặc định.

To revert to the factory-default configuration by using the request system zeroize command:
```
user@switch> request system zeroize
warning: System will be rebooted and may not boot without configuration
Erase all data, including configuration and log files? [yes,no] (yes)
```
Type yes to remove configuration and log files and revert to the factory-default configuration.




(có thể sẽ còn tiếp)

