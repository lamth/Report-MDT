<header>
Tìm hiểu làm việc với Virtual Environment.
</header>

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
source my_project_env/bin/activate
```
Cài đặt gói:
```
pip install requests
```

Thoát khỏi môi trường VirtualEnv
Để ngưng (thoát) sử dụng môi trường ảo hiện tại. Sử dụng câu lệnh dưới đây:
```
deactivate
```
