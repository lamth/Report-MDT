# Tìm hiểu cơ bản về log.

Các mục tìm hiểu trong bài:
- [Khái niệm tổng quan.](#khainiem)
- [Syslog và Rsyslog](#syslog)
- [Một số thuật ngữ cơ bản trong logging](#thuatngu)
- [Các nguồn sinh ra log](#nguonlog)
- [File cấu hình của syslog](#configfile)
- [Các mức độ cảnh báo của log](mucdo)
- [Lệnh `logger` thao tác với log](#loggercommand)
- [Tìm hiểu log rotation và lab.](#logrotate)
- [Tìm hiểu sử dụng rsyslog đẩy log](#rsyslog) 



<a name=khainiem></a>

## 1.Khái niệm về log?

**Log** hay **log file** là một tệp được tạo ra bởi các máy chủ, ứng dụng chứa thông tin về các hoạt động, trạng thái, các đăng nhập,lỗi,... của các máy chủ hay ứng dụng đó.

Các file log của hệ thống thường sẽ chứa thông tin về các chức năng thiết yếu trong hệ thống như cơ chế ủy quyền, các message hệ thống, thông tin về phần cứng máy chủ,...

Tác dụng của log:
- File log liên tục ghi lại các thông báo cần thiết của hệ thống hoặc các ứng dụng, dịch vụ. Log file thường được ghi dưới dạng clear text, có thể dễ dàng xem bằng các text editor (vim, nano,..) hay các lệnh xem văn bản thông thường(tail, head, cat, awk,...).
- Log giúp rất nhiều trong quá trình giải quyết các rắc rối gặp phải đối với hệ thống.
- Trong Linux, Log file thường sẽ nằm ở thư mục `/var/log`

Việc sinh ra log để giúp quản trị viên theo dõi hệ thống của mình tốt hơn, hoặc giải quyết các vấn đề gặp phải với hệ thống hoặc service. Điều này đặc biệt quan trọng với các hệ thống cần phải online 24/24 để phục vụ nhu cầu của mọi người dùng.


<a name=syslog></a>

## 2. Syslog
### 2.1. Syslog
- Là phương thức chính để lưu log trên linux. 
- Sử dụng cơ chế client/server với daemon là syslogd. Syslogd nhận tin nhắn trên port 514 từ nhiều ứng dụng khác. Cấu hình syslogd ở `/etc/syslogd.conf`

- Trong linux, syslog là giao thức được sử dụng bởi rsyslog.
<a name=thuatngu></a>

## 3. Một số thuật ngữ trong logging (syslog)
| **Thuật ngữ** |  **Mô tả**|
|---------------|-----------|
| Facility      | Trong syslog có thể coi facility là nguồn tạo ra log |
| Priority      | Priority của log để xác định mức độ quan trọng của log |
| Selector      | Là sự kết hợp của Facility và Priority (Fancility.Priority) của một event log để lọc và xác định các evenlog có Selector này thì tương ứng với action là gì.|
| Action | Từ việc xác định selector cho log, log sẽ được xử lý theo action được xác định, ví dụ như gửi đến server khác, loại bỏ,...|

<a name=nguonlog></a>

## 4. Phân loại các nguồn sinh ra log(Facility)

| Facility Number | Nguồn | Ý nghĩa |
|-----------------|-------|---------|
| 0 | kernel | Những log do kernel sinh ra |
| 1 | user | Log ghi lại cấp độ người dùng |
| 2 | mail | Log của hệ thống mail |
| 3 | daemon | Log của các tiến trình trên hệ thống |
| 4 | auth | Log từ quá trình đăng nhập hệ thống hoặc xác thực hệ thống |
| 5 | syslog | Log từ chương trình syslogd |
| 6 | lpr | Log từ quá trình in ấn |
| 7 | news | Thông tin từ hệ thống |
| 8 | uucp | Log UUCP subsystem | 
| 9 | | Clock daemon |
| 10 | authpriv | Quá trình đăng nhập hoặc xác thực hệ thống |
| 11 | ftp | Log của FTP daemon |
| 12 | ntp | Log từ dịch vụ NTP của các subserver |
| 13 | security | Kiểm tra đăng nhập |
| 14 | console | Log cảnh báo hệ thống |
| 15 | cron | Log từ clock daemon |
| 16 - 23 | local 0 - local 7 | Log dự trữ cho sử dụng nội bộ|

<a name=mucdo></a>

## 5. Các mức dộ cảnh báo log.

| Code | Mức cảnh báo | Ý nghĩa | 
|------|--------------|---------|
| 0 | emerg | Thông báo tình trạng khẩn cấp |
| 1 | alert | Hệ thống cần can thiệp ngay |
| 2 | crit | Tình trạng nguy kịch | 
| 3 | error | Thông báo lỗi đối với hệ thống | 
| 4 | warn | Mức cảnh báo đối với hệ thống |
| 5 | notice | Chú ý đối với hệ thống | 
| 6 | info | Thông tin của hệ thống |
| 7 | debug | Quá trình kiểm tra hệ thống | 

<a name=configfile></a>

## 6. File cấu hình của rsyslog

Trong CENTOS, file cấu hình là /etc/rsyslog.conf . File này chứa cả các rule về log
Trong UBUNTU file cấu hình là /etc/rsyslog.conf nhưng các rule được định nghĩa riêng trong /etc/rsyslog.d/50-defaul.conf .

File rule này được khai báo include từ file cấu hình /etc/rsyslog.conf Dưới đây là file cấu hình và khai báo rule trong CENTOS
```conf
# rsyslog configuration file

# For more information see /usr/share/doc/rsyslog-*/rsyslog_conf.html
# If you experience problems, see http://www.rsyslog.com/doc/troubleshoot.html

#### MODULES ####

# The imjournal module bellow is now used as a message source instead of imuxsock.
$ModLoad imuxsock # provides support for local system logging (e.g. via logger command)
$ModLoad imjournal # provides access to the systemd journal
#$ModLoad imklog # reads kernel messages (the same are read from journald)
#$ModLoad immark  # provides --MARK-- message capability

# Provides UDP syslog reception
#$ModLoad imudp
#$UDPServerRun 514

# Provides TCP syslog reception
#$ModLoad imtcp
#$InputTCPServerRun 514


#### GLOBAL DIRECTIVES ####

# Where to place auxiliary files
$WorkDirectory /var/lib/rsyslog

# Use default timestamp format
$ActionFileDefaultTemplate RSYSLOG_TraditionalFileFormat

# File syncing capability is disabled by default. This feature is usually not required,
# not useful and an extreme performance hit
#$ActionFileEnableSync on

# Include all config files in /etc/rsyslog.d/
$IncludeConfig /etc/rsyslog.d/*.conf

# Turn off message reception via local log socket;
# local messages are retrieved through imjournal now.
$OmitLocalLogging on

# File to store the position in the journal
$IMJournalStateFile imjournal.state


#### RULES ####

# Log all kernel messages to the console.
# Logging much else clutters up the screen.
#kern.*                                                 /dev/console

# Log anything (except mail) of level info or higher.
# Don't log private authentication messages!
*.info;mail.none;authpriv.none;cron.none                /var/log/messages

# The authpriv file has restricted access.
authpriv.*                                              /var/log/secure

# Log all the mail messages in one place.
mail.*                                                  -/var/log/maillog


# Log cron stuff
cron.*                                                  /var/log/cron

# Everybody gets emergency messages
*.emerg                                                 :omusrmsg:*

# Save news errors of level crit and higher in a special file.
uucp,news.crit                                          /var/log/spooler

# Save boot messages also to boot.log
local7.*                                                /var/log/boot.log


# ### begin forwarding rule ###
# The statement between the begin ... end define a SINGLE forwarding
# rule. They belong together, do NOT split them. If you create multiple
# forwarding rules, duplicate the whole block!
# Remote Logging (we use TCP for reliable delivery)
#
# An on-disk queue is created for this action. If the remote host is
# down, messages are spooled to disk and sent when it is up again.
#$ActionQueueFileName fwdRule1 # unique name prefix for spool files
#$ActionQueueMaxDiskSpace 1g   # 1gb space limit (use as much as possible)
#$ActionQueueSaveOnShutdown on # save messages to disk on shutdown
#$ActionQueueType LinkedList   # run asynchronously
#$ActionResumeRetryCount -1    # infinite retries if host is down
# remote host is: name/ip:port, e.g. 192.168.0.1:514, port optional
#*.* @@remote-host:514
# ### end of the forwarding rule ###

```

Dựa vào file cấu hình rsyslog, chúng ta có thể thấy cấu trúc của một rule sẽ gồm **selector** và **action** với selector đó:
```
facility.priority               action
```
Một số ví dụ:
- Ghi log đến từ tiến trình cron ở mọi cấp độ vào file `/var/log/cron`:
```conf
# Log cron stuff
cron.*                                                  /var/log/cron
```
- Ghi tất cả các log vào file `/var/log/message` từ mức độ info, trừ các log đến từ mail, authpriv và cron:
```
*.info;mail.none;authpriv.none;cron.none                /var/log/messages
```
- Gửi tất cả log ở mức độ emerg đến user teminal:
```
# Everybody gets emergency messages
*.emerg                                                 :omusrmsg:*
```
- Nếu chỉ muốn mail ghi lại các log với mức là info
```
mail.=info		/var/log/mail
```

<a name=loggercommand></a>

## Tìm hiểu làm việc với lệnh `logger`.

Lệnh `logger` là lệnh dùng đệ gửi log message đến hệ thống ghi log. 
Lệnh này có thể được sử dụng để kiểm tra hoạt động của hệ thống ghi log.

Định dạng cơ bản của lệnh `logger`:
```
logger [-i] [-f file] [-p priority] [-t tag] message
```

với:
- `-i` - LogID
- `-f file` - định nghĩa file dùng làm log
- `-p priority` - mức độ ưu tiên của log
- `-t tag` - cấu hình tag, tag được đính kèm tại mỗi dòng log
- `message` - nội dung log.


## Log rotation

Logrotate là một công cụ chương trình hỗ trợ cho việc quản lý các file log trên hệ thống.

Rotate ở đây có thể hiểu là tiến trình tạo ra 1 file log mới, còn file log cũ sẽ được xử lý theo các quy định cấu hình như xoá đi/nén lại/cất đi đâu đó.

Logrotate đơn thuần là một chương trình hoạt động theo việc xếp lịch crontab chứ không phải là một dịch vụ.

File cấu hình mặc định là /etc/logrotate.conf



## Các mục tìm hiểu trong bài:
- [Khái niệm tổng quan.](#khainiem)
- [Syslog và Rsyslog](#syslog)
- [Một số thuật ngữ cơ bản trong logging](#thuatngu)
- [Các nguồn sinh ra log](#nguonlog)
- [File cấu hình của syslog](#configfile)
- [Các mức độ cảnh báo của log](mucdo)
- [Lệnh `logger` thao tác với log](#loggercommand)
- [Tìm hiểu log rotation và lab.](#logrotate)
 

[Tìm hiểu thêm về quản lý log tập trung bằng ELK stack](https://github.com/lamth/ghichep-ELK)


## Nguồn
- https://github.com/doedoe12/Internship/blob/e8f8c524aacc623299794a947c76139e1c7967f5/Tim_hieu_ve_log/Overview.md
- https://github.com/trangnth/Tim-hieu-ELK
- https://blog.cloud365.vn/logging/nhap-mon-logging-phan3/