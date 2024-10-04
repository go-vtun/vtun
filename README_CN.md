# vtun

一款简单易用的VPN，基于Go语言开发。

[EN](https://github.com/go-vtun/vtun/blob/main/README.md) | [中文](https://github.com/go-vtun/vtun/blob/main/README_CN.md)

[![Travis](https://travis-ci.com/go-vtun/vtun.svg?branch=main)](https://github.com/go-vtun/vtun)
[![Go Report Card](https://goreportcard.com/badge/github.com/go-vtun/vtun)](https://goreportcard.com/report/github.com/go-vtun/vtun)
![image](https://img.shields.io/badge/License-MIT-orange)
![image](https://img.shields.io/badge/License-Anti--996-red)
![image](https://img.shields.io/github/downloads/go-vtun/vtun/total.svg)

# 特性
* 支持udp
* 支持websocket
* 支持tls
* 支持grpc
* 支持quic
* 支持kcp
* 支持utls
* 支持dtls
* 支持h2
* 支持http
* 支持tcp
* 支持https

# 用法

```
Usage of vtun:
  -S  server mode
  -c string
      tun interface cidr (default "172.16.0.10/24")
  -c6 string
      tun interface ipv6 cidr (default "fced:9999::9999/64")
  -certificate string
      tls certificate file path (default "./certs/server.pem")
  -compress
      enable data compression
  -dn string
      device name
  -f string
      config file
  -g  client global mode
  -host string
      http host
  -isv
      tls insecure skip verify
  -k string
      key (default "freedom@2023")
  -l string
      local address (default ":3000")
  -mtu int
      tun mtu (default 1500)
  -obfs
      enable data obfuscation
  -p string
      protocol udp/tls/grpc/quic/utls/dtls/h2/http/tcp/https/ws/wss (default "udp")
  -path string
      websocket path (default "/freedom")
  -privatekey string
      tls certificate key file path (default "./certs/server.key")
  -psk
      enable psk mode (dtls only)
  -s string
      server address (default ":3001")
  -sip string
      server ip (default "172.16.0.1")
  -sip6 string
      server ipv6 (default "fced:9999::1")
  -sni string
      tls handshake sni
  -t int
      dial timeout in seconds (default 30)
  -v  enable verbose output
```

## 编译

```
scripts/build.sh
```

## Linux客户端

```
sudo ./vtun-linux-amd64 -s server-addr:3001 -c 172.16.0.10/24 -k 123456

```

## Linux全局模式客户端（转发所有流量）

```
sudo ./vtun-linux-amd64 -s server-addr:3001 -c 172.16.0.10/24 -k 123456 -g

```
## MacOS客户端

```
sudo ./vtun-darwin-amd64 -s server-addr:3001 -c 172.16.0.10/24 -k 123456 -g -sip 172.16.0.1

```

## Windows客户端
在windows上使用，你必须下载[wintun.dll](https://www.wintun.net/)文件并且把它放到当前应用目录下。  
用管理员权限打开powershell并运行命令:
```
.\vtun-win-amd64.exe  -s server-addr:3001 -c 172.16.0.10/24 -k 123456 -g -sip 172.16.0.1

```

## Linux服务端

```
sudo ./vtun-linux-amd64 -S -l :3001 -c 172.16.0.1/24 -k 123456

```

## 在Linux服务器上设置iptables

```
  # 设置ipv4和ipv6流量转发
  vi /etc/sysctl.conf
  net.ipv4.ip_forward = 1
  net.ipv6.conf.all.forwarding=1
  sysctl -p /etc/sysctl.conf
  # 设置NAT转发流量
  iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
  iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
  iptables -A INPUT -i eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
  iptables -A INPUT -i tun0 -m state --state RELATED,ESTABLISHED -j ACCEPT
  iptables -A FORWARD -j ACCEPT
  

```

## 如何编译移动应用依赖库


### 1. 安装 gomobile
```
go install golang.org/x/mobile/cmd/gomobile@latest
gomobile init
```

### 2. 安装安卓 [ndk](https://developer.android.com/studio/projects/install-ndk)


### 3. 编译安卓.aar文件
```
make android
```


## 移动端

### 1. GoFly VPN
<p>
<a href="https://play.google.com/store/apps/details?id=app.fjj.gofly"><img src="https://play.google.com/intl/en_us/badges/images/generic/en-play-badge.png" height="100"></a>
</p>

# License
[The MIT License (MIT)](https://raw.githubusercontent.com/go-vtun/vtun/main/LICENSE)

# 致谢
感谢 [JetBrains](https://www.jetbrains.com/community/opensource/#support) 提供免费的License.

<img src="https://resources.jetbrains.com/storage/products/company/brand/logos/jb_beam.png" alt="JetBrains Logo (Main) logo." width="100px">
