## Tài liệu tìm hiểu Linux cơ bản.

```
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
[sudo] password for lamth: 
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   617    0   617    0     0    444      0 --:--:--  0:00:01 --:--:--   444
100 15.4M  100 15.4M    0     0   102k      0  0:02:34  0:02:34 --:--:--  300k
```

```
lamth@m4700:~$ sudo chmod +x /usr/local/bin/docker-compose 
[sudo] password for lamth: 
lamth@m4700:~$ docker-compose --version 
docker-compose version 1.24.0, build 0aa59064

```