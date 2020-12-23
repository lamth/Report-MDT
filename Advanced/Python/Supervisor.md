<header> Triển khai một ứng dụng Flask </header>

![](https://miro.medium.com/proxy/1*nFxyDwJ2DEH1G5PMKPMj1g.png)


Tài liệu tham khảo:

https://thucnc.medium.com/deploy-a-python-flask-restful-api-app-with-gunicorn-supervisor-and-nginx-62b20d62691f

Triển khai ứng dụng Python Flask sử dụng `gunicorn`, `supervisord` và `nginx`.  

# Cài đặt môi trường
Tạo Virtualenv, trong thư mục dự án:
```
pip3 install virtualenv
# Trong trường hợp sử dụng phiên bản python khác thì cần thay thế trong câu lệnh dưới đây
virtualenv -p python3.8 ./.venv  
source ./.vent/bin/activate
# Kiểm tra phiên bản python xem đã đúng chưa
python --version
pip --version
```

Cài đặt môi trường:
```
pip install -r ./src/requirements.txt
```


Cấu trúc code:
```
/
|_ src
|    |_ main.py
|    |_ requirements.txt
|_ .venv
|_ config
|    |_ gunicorn
|    |_ supervisor
|_ readme.md 
```

# Thiết lập và cấu hình `gunicorn`

Có thể chạy chương trình Flask sử dụng web server tích hợp nhưng nó không dành cho môi trường production vì nó không có khả năng mở rộng tốt. Do đó, sử dụng `gunicorn` là một lựa chọn tốt để chạy được

""