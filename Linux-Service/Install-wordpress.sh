#!/bin/bash


sleep 1
echo -e "Script cài đặt Wordpress \n"
sleep 1

function check_and_install_LAMP()
{
    echo 'Kiểm tra và cài đặt các package'

    # Danh sách các package cần cài đặt, và các package xung đột cần kiểm tra và gỡ bỏ.
    package=(httpd php71-php php71-php-mysqlnd MariaDB-server MariaDB-client wget unzip)
    remove_package=(nginx mysql mysql-server MariaDB-server MariaDB-client mariadb mariadb-server)


    echo "Đang cài đặt Repo"
    yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm &> /dev/null
    yum -y install epel-release &> /dev/null

    # Cấu hình để cài đặt php 7.1 làm mặc định
    sudo yum-config-manager --enable remi-php71

cat << EOF > /etc/yum.repos.d/MariaDB.repo
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.1/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
EOF

    echo 'Đang kiểm tra các package xung đột'
    for pack in "${remove_package[@]}"
    do 
        if rpm -q $pack 
        then 
            echo "Đang gỡ cài đặt $pack"
            yum remove -y $pack > /dev/null
        else 
            echo "Package $pack chưa được cài đặt"
        fi
    done

    rm -rf /var/lib/mysql
    rm /etc/my.cnf
    
    echo "Đang kiểm tra và cài đặt các package cần thiết."
    for pack in ${package[@]}
    do 
        if rpm -q $pack 
        then 
            echo -e "Package $pack đã được cài đặt \n"
        else 
            echo "Đang cài đặt package $pack "
            yum install -y $pack > /dev/null
        fi
    done


}

function install_wordpress()

{
    echo "Cấu hình MariaDB"
    systemctl start mariadb
    systemctl enable mariadb

    read -s -p "Password cho tài khoản root: " sql_rootpass

    echo $sql_rootpass > /root/sql_rootpass.txt

#    read -p "User cho Wordpress để truy cập vào MariaDB" sql_user
#    read -s -p "Password cho tài khoản $sql_user" sql_userpass

    # Cấu hình mật khẩu cho tài khoản root mariadb
    /usr/bin/mysqladmin -u root -h localhost password $sql_rootpass > /dev/null
    

# Tạo database cho wordpress
mysql -u root --password=$sql_rootpass <<EOF
DROP DATABASE IF EXISTS wordpress;
CREATE DATABASE wordpress;
EOF
    

    echo -e "\n ---- \n Tải và cấu hình Wordpress \n ----"


    rm -rf /tmp/wordpress.zip ||:
    rm -rf /tmp/wordpress ||:
    rm -rf /var/www/html/* ||:

    # Tải và unzip wordpress
    wget https://wordpress.org/latest.zip -O /tmp/wordpress.zip &> /dev/null
    unzip /tmp/wordpress.zip -d /tmp/ &> /dev/null
    cd /tmp/wordpress
    cp wp-config-sample.php wp-config.php

    # Cấu hình wordpress kết nối đến database
    sed -i -e "s/database_name_here/wordpress/g" /tmp/wordpress/wp-config.php

    sed -i -e "s/username_here/root/g" /tmp/wordpress/wp-config.php

    sed -i -e "s/password_here/$sql_rootpass/g" /tmp/wordpress/wp-config.php


    # Chuyển thư mục wordpress đến thư mục DocumentRoot của apache.
    mv  /tmp/wordpress/* /var/www/html/
    chown -R apache:apache /var/www/html/*

    echo 'Cấu hình wordpress thành công'


}


function service_firewall()
{
    echo "Cấu hình khởi chạy các dịch vụ"
    systemctl -n 0 start firewalld
    systemctl -n 0 enable firewalld
    systemctl -n 0 start httpd
    systemctl -n 0 restart httpd
    systemctl -n 0 enable httpd 
    systemctl -n 0 start mariadb
    systemctl -n 0 restart mariadb
    systemctl -n 0 enable mariadb

    echo 'Cấu hình firewalld'
    firewall-cmd --add-service=http --permanent 
    firewall-cmd --reload
 
}

check_and_install_LAMP
install_wordpress
service_firewall

echo "Cài đặt thành công"
echo "Mật khẩu tài khoản root của mariadb lưu tại /root/sql_rootpass.txt "

