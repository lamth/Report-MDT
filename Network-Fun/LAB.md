## 1. Reset switch về cấu hình mặc định.
- Bật nguồn đồng thời giữ nút mode để vào được chế độ như trong hinh:
![](http://i.imgur.com/0dweIn9.png)
- Chạy `flash_init` để khởi tạo file flash.
- Xóa *config.text* trong thư mục flash:
`del flash:config.text`
![](http://i.imgur.com/l1Bjd0G.png)
- Xóa *vlan.dat*:
`del flash:vlan.dat`
![](http://i.imgur.com/RPtt7qJ.png)
- khởi động lại switch :
![](http://i.imgur.com/0k4fwLG.png)

## 2.Reset Router 1841.

- set baud rate(speed) về 1200
- tắt router bà bật lại.

## 3.Cấu hình trên router R1
```
# cấu hình hostname,ssh
enable
config terminal

hostname R
enable password 123
username lam secret 123
ip domain-name meditech
crypto key generate rsa general-keys modulus 1024
line vty 0 4
transport input ssh
password 123
login local


int f0/0
ip add 192.168.1.45 255.255.255.0
no shut

# cấu hình các sub interface làm gateway cho các vlan.
int f0/1
no shut
int f0/1.81
encapsolution dot1q 81
ip add 192.168.81.1 255.255.255.0
int f0/1.82
encapsolution dot1q 82
ip add 192.168.82.1 255.255.255.0

ip route 0.0.0.0 0.0.0.0 192.168.100.1


# Caaus hinh NAT de mang trong ra ngoai internet
access-list 1 permit any
ip nat inside source list 1 interface f0/0 overload
interface f0/0
ip nat outside
interface f0/1.81
ip nat inside
interface f0/1.82
ip nat inside
```


## 4.Cấu hình trên SW-C

```

## hostname va ssh
enable
conf t
hostname SW-C
enable password 123
username lam password 123
ip domain-name meditech
crypto key generate rsa general-keys modulus 1024
line vty 0 4
transport input ssh
password 123
login local

## Cau hinh VTP
vtp mode server
vtp domain meditech
vtp password 123

int range f0/1-2
switchport trunk encapsulation dot1q
switchport mode trunks

## Cau hinh Vlan.
vlan 81
vlan 82

int vlan 81
ip add 192.168.81.2 255.255.255.0
no shut
int vlan 82
ip add 192.168.82.2 255.255.255.0

# Cau hinhf Dhcp server.
ip dhcp excluded-address 192.168.81.1 192.168.81.10
ip dhcp excluded-address 192.168.82.1 192.168.82.10
ip dhcp pool vlan81
network 192.168.81.0 255.255.255.0
default-router 192.168.81.1  
ip dhcp pool vlan82
network 192.168.82.0 255.255.255.0
default-router 192.168.82.1

do wr



```
## 5. Cấu hình trên SW-A.

```
enable
conf t
hostname SW-A
enable password 123
username lam password 123
ip domain-name meditech
crypto key generate rsa general-keys modulus 1024
line vty 0 4
transport input ssh
password 123
login local


vtp mode client
vtp domain meditech
vtp password 123

int f0/24
switchport mode trunk

## sau khi nhận cấu hình vlan
int range f0/1-10
switchport mode access
switchport access vlan 81
int range f0/11-20
switchport mode access
switchport access vlan 82

int vlan 81
ip add 192.168.81.3

## Cấu hình ssh
username lam password 123
ip domain-name meditech
crypto key generate rsa general-keys modulus 1024
line vty 0 4
transport input ssh
password 123
login local


do wr

```
