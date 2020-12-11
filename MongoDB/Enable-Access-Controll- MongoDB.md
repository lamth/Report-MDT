<header>
Bật tính năng kiểm soát truy cập cho Mongodb.
============
</header>

# Mục lục

[1. Tổng quan](#tổng-quan)
User Administrator
Procedure
Additional Considerations



# 1. Tổng quan
Việc bật tính năng kiểm soát truy cập cho MongoDB sẽ thực hiện việc xác thực, yêu cầu người dùng định danh chính họ. Khi truy cập MongoDB mà có kiểm soát truy cập được bật, người dùng chỉ có thể thực hiện các hành động mà được quyết định theo vai trò(role) của họ

Hướng dẫn sau đây bật kiểm soát truy cập trên một mongod một mình(không theo cụm) và sử dụng cơ chế xác thực mặc định (SCRAM).

# 2. Quản trị viên người dùng(User Administrator)

Khi bật kiểm soát truy cập, chắc chắn rằng bạn có người dùng có vai trò là *userAdmin* hoặc *userAdminAnyDatabase* trong database **admin**. Người dùng này có thể quản lý người dùng và các role như: tạo người dùng, gán và gỡ vai trò từ người dụng, tạo và sửa các role tùy chọn.


# 3. Thực hiện
Thực hiện tạo quản trị viên người dùng cho một mongodb đang chạy mà không bật kiểm soát truy cập, sau đó bật chức năng này lên.

## 3.1. Bật mongodb không sử dụng kiểm soát truy cập
Bật một mongod instance không sử dụng kiểm soát truy cập ví dụ như:
```
mongod --port 27017 --dbpath /var/lib/mongodb
```

## 3.2. Kết nối đến mongo
Ví dụ mở một terminal mới và kết nối đến mongo shell của instance bằng lệnh `mongo`. Ví dụ:
```
mongo --port 27017 -h localhost
```

## 3.3. Tạo quản trị viên người dùng.
Từ mongo shell, thêm user với vai trò(role) là *userAdminAnyDatabase* trong database **admin**. Và bao gồm các role khác nếu cần cho user này. Ví dụ sau tạo user **myUserAdmin** trong database **admin** với role là **userAdminAnyDatabase** và **readWriteAnyDatabase**.


```js
use admin
db.createUser(
  {
    user: "myUserAdmin",
    pwd: passwordPrompt(), // or cleartext password
    roles: [ { role: "userAdminAnyDatabase", db: "admin" }, "readWriteAnyDatabase" ]
  }
)
```

Tắt mongod

## 3.4. Cấu hình bật kiểm soát truy cập
Sửa file cấu hình ở phần sau:
```
security:
  authorization: enabled
```

Khởi động lại mongod

## 3.5. Kết nối đến mongo

```
mongo -u myUserAdmin -p --authenticationDatabase "admin"
``` 



#  Nguồn
- https://docs.mongodb.com/manual/tutorial/enable-authentication/