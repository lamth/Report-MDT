# Ansible

Bài viết này mình chỉ viết lại cho nhớ thôi, Tham khảo từ một số nguồn: 
https://github.com/VNPT-SmartCloud-System/Tim-hieu-Ansible
https://docs.ansible.com/




- [I. Tổng quan về Ansible?](#tongquan)
- [II. Ansible Role và Ansible Galaxy](#role)


<a name=tongquan></a>

## I. Tổng quan về Ansible?

**Ansible** là một công cụ mã nguồn mở được sử dụng để tự động hóa các tác vụ it như triển khai hệ thống, dịch vụ, quản lý các cài đặt, thiết lập của hệ thống hay dịch vụ, điều phối các dịch vụ nội bộ,...

Sử dụng *SSH* và các module(được viết bằng Python) để cấu hình, điều khiển hệ thống.

Sử dụng *Json* để hiển thị thông tin và sử dụng *YAML* để xây dựng mô tả cấu trúc hệ thống.

### Đặc điểm của Ansible
- Không cần các agent chỉ cần cài lên master
- Không sử dụng các service, daemon mà chỉ thực thi khi được gọi.
- Bảo mật cao khi sử dụng SSH. Có tùy chọn sử dụng mật khẩu, tuy nhiên sử dụng SSH key là cách tốt nhất để sử dụng với Ansible.
- Sử dụng các ngôn ngữ dễ đọc, dễ hiểu và dễ viết.

### Kiến trúc Ansible.

![](https://i.imgur.com/tAM7eIB.png)

- **Modules** - Modules là các chương trình nhỏ được viết bằng Python, được Ansible gửi đến server để thực hiện các yêu cầu mong muốn trên server. Ví dụ như module **yum**, được Ansible gửi đến các server, thực thi để cài đặt các gói phần mềm qua yum.
- **Plugins** Là các đoạn mã để cấu hình thêm các chức năng mở rộng cho Ansible. Có thể tự viết và thêm plugins cho Ansible để thêm các chức năng phù hợp với nhu cầu sử dụng.

- **Inventory** - Là file(INI hoặc YAML,...) dùng để biểu diễn các server mà Ansible quản lý. Thường là file /etc/ansible/hosts`

- **Playbook** - Là một file YAML chứa các chỉ dẫn cấu hình cho các lớp trong hạ tầng. Chứa các *play* dùng để kết nối các host với các role cho các host. Các role hay các task thực hiện việc gọi đến một module nào đó.

### Cách ansible hoạt động
Ansible có hai loại là control machine(server) và node. Control machine là server chịu tránh nhiệm quản lý các node con trong hệ thống, lưu trữ thông tin về các node, playbook, script cần dùng để triển khai trên các node khác qua SSH.

Ví dụ về workflow trên Linux remote :
- Ansible sẽ khởi tạo file python tổng hợp với nội dung từ các module chỉ định và các tham số biến truyền vào. File python này sẽ sử dụng cho tác vụ chạy trên máy chủ remote.
- Kết nối SSH (key hoặc authen pass) đến máy chủ remote theo thông tin inventory host cung cấp, khởi tạo thư mục tạm ở thư mục $HOME user kết nối.
- Upload file python lên thư mục tạm của thư mục $HOME user kết nối.
- Chạy file python tác vụ và khi hoàn tất thì xoá thư mục tạm.
- Lấy thông tin kết quả thực thi tác vụ (failed hoặc ok), rồi trả về thông tin ở định dạng json.

Khi không có lệnh Ansible nào được thực thi thì máy chủ sẽ không bị ansible chiếm tài nguyên vì Ansible không sử dụng daemon hay chường chình nào. Nó chỉ chiếm tài nguyên hệ thông khi thực thi.

### Làm việc với Ansible.
Mô hình:
- Controller machine: 
    - 192.168.104.140
    - Centos 7
- Node: 
    - 192.168.104.150
    - Centos 7


#### Cài đặt Ansible.
##### Cài đặt trên Ansible server- Controller machine:
- Cài đặt trên CentOS: 
```
sudo yum update
sudo yum install epel-release
sudo yum install ansible
```
- Nếu sử dụng Ubuntu 20: 
```
sudo apt update
sudo apt install ansible
```
- Khai báo các host vào file inventory:
```
cat << EOF > /etc/ansible/hosts
[testnode]
192.168.104.150
EOF
```

##### Trên node
Cài đặt Python 2.7 trở lên và cấu hình bật và mở port ssh server.

#### Kiểm tra kết nối từ Ansible server đến node
Sử dụng lệnh sau để kiểm tra kết nối giữa server và node:
```
ansible  testnode -m ping -u root -k
```
![](https://i.imgur.com/MQqN58K.png)

trong đó:
- **-i** : đường dẫn host define
- **-m** : là loại module
- **-u** : là user
- **-k** : password của user

### Playbook
Thay vì sử dụng các lệnh để thực thi, Ansible hỗ trợ file Playbook. Playbook là một file yaml, ghi lại một list các host và các task, và khi gọi file playbook này thì các task sẽ lần lượt thực thi (gần giống shell script trong Linux) 

Ví dụ về shell script và ansible playbook:

```
install-nginx.sh
```
```bash
#!/bin/bash

# Update apt cache
sudo apt update

# Install NGINX
sudo apt install -y nginx

# Start the nginx service
sudo systemctl start nginx

# Enable nginx service on system boot
sudo systemctl enable nginx
```

```
install-nginx.yml
```
```yml
---
- hosts: testnode
  become: yes

  tasks:
    - name: Update apt cache.
      command: apt update

    - name: Install NGINX web server.
      command: apt install -y nginx

    - name: Start the nginx service.
      command: systemctl start nginx

    - name: Enable nginx service at system boot.
      command: systemctl enable nginx
```

Chi tiết:
- `---` : Dòng đầu tiên cho chúng ta biết nội dung của file sẽ được viết theo cú pháp YAML

- `- hosts: testnode` : Play này sẽ được chạy trên tất cả các hosts trong nhóm có tên là testnode.

- `- become : yes` : Chỉ định rằng tất cả các command trong play sẽ được chạy dưới quyền sudo

- `tasks: `: Đây là danh sách các công việc được thực hiện trong play. Mỗi task sẽ à một object trong YAML và thông thường được đặt tên thông qua name. Từ đó cho phép chúng ta theo dõi quá trình thực hiện của playbook dễ dàng hơn.

### Viết lại file Playbook.

Thay vì sử dụng module `command` chúng ta có thể sử dụng module `apt` để quản lý các package bằng apt.

| Lệnh                       | ansible playbook syntax         |
|----------------------------|---------------------------------|
| apt update                 | - name: Update apt cache. <br> apt: update_cache=yes cache_valid_time=3600|
| apt install -y nginx       | - name: Install NGINX web server. <br>  apt: name=nginx state=present |
| systemctl start nginx <br> systemctl enable nginx| - name: Start and enable nginx service at system boot.<br> service: name=nginx state=started enabled=yes |

Đây là nội dung của file install-nginx.yml sau khi đã chỉnh sửa lại :
```
---
- hosts: testnode
  become: yes

  tasks:
    - name: Update apt cache.
      apt: update_cache=yes cache_valid_time=3600

    - name: Install NGINX web server.
      apt: name=nginx state=present

    - name: Start and enable nginx service at system boot.
      service: name=nginx state=started enabled=yes
```

<a name=role></a>

# II. Ansible Role và Ansible Galaxy
## 1. Ansible role
Ansible role là một bộ các tasks để cấu hình một host nhằm phục vụ một mục đích chính như là cấu hình một dịch vụ.
Nó là một cơ chế để tách playbook thành nhiều file, để đơn giản hóa việc viết các playbook phức tạp để tái sử dụng lại nhiều lần .
Role được định nghĩa sử dụng các file YAML với cấu trúc thư mục được định nghĩa trước.

Một cấu trúc thư mục của role gồm các thư mục: `defaults`, `vars`, `tasks`, `files`, `templates`, `meta`, `handlers`.Mỗi thư mục đều phải chứa một file main.yml chứa các nội dung liên quan đến thư mục đó. Chi tiết về các thư mục:
- **defaults**: là thư mục chứa các biến mặc định cho role. Các biến trong thư mục này có đặc quyền thấp nhất nên nó dễ dàng bị ghi đè.
- **vars**: chứa các biến của role có đặc quyền cao hơn và có thể ghi đè các biến ở trong defaults.
- **tasks**: Chứa danh sách chính của các bước sẽ được thực thi bởi role
- **files**: chứa các file mà chúng ta muốn copy đến các host. Không cần chỉ định đường dẫn tới các file trong thư mục này.
- **templates**: chứa các file mẫu mà hỗ trợ chỉnh sửa từ role. Chúng ta có thể tạo file templates sử dụng Jinja2 templating.
- **meta**: chứa các metadata của role như tác giả, thông tin về nền tảng hỗ trợ, các dependencies.
- **handlers**: chứa các trình sử lý mà có thể được gọi bởi chỉ thị `notify` và được liên kết với dịch vụ.

Một role phải có ít nhất một trong 7 thư mục trên để được Ansible coi là một role.

Ví dụ về role trong việc triển khai dịch vụ nginx.









Nguồn tham khảo:
https://medium.com/@mitesh_shamra/ansible-roles-1d1954f9932a
