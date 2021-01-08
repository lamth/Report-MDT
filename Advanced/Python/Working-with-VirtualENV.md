# Tìm hiểu làm việc với Virtual Environment.

# Virtual Environment là gì?

Virtual Environment() là môi trường ảo, sinh ra để quản lý môi trường làm việc độc lập cho từng dự án. Vì mỗi dự án sẽ cần phiên bản Python khác nhau, thư viện khác nhau, module khác nhau, do đó, việc sử dụng virtual environment sẽ tránh tình trạng không tương thích môi trường giữa các dự án.


# Cài đặt Virtual Environment

Yêu cầu: Cài đặt sẵn Python 3 và pip3

Trên terminal:
```
pip3 install virtualenv
```

Kiểm tra việc cài đặt:
```
virtualenv --version
```

# Tạo Virtual Environment

Chuyển đến thư mục dự án:
```
cd myproject
```
Tạo môi trường ảo trong thư mục dự án:
```
virtualenv lamth_env
```



# Kích hoạt sử dụng VirtualEnv
Để bắt đầu sử dụng thì cần kích hoạt virtualenv này
```
source lamth_env/bin/activate
```

Cài đặt gói:
```
pip install requests
```

Hiển thị các gói được cài đặt bằng pip3 và phiên bản của chúng:
```
pip3 freeze
```
output
```
click==7.1.2
dnspython==1.16.0
eventlet==0.29.1
Flask==1.1.2
greenlet==0.4.17
gunicorn==20.0.4
ipaddress==1.0.23
itsdangerous==1.1.0
Jinja2==2.11.2
MarkupSafe==1.1.1
six==1.15.0
Werkzeug==1.0.1
```

Thoát khỏi môi trường VirtualEnv
Để ngưng (thoát) sử dụng môi trường ảo hiện tại. Sử dụng câu lệnh dưới đây:
```
deactivate
```
