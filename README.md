# vtun

A simple VPN written in Go.

[EN](https://github.com/go-vtun/vtun/blob/main/README.md) | [中文](https://github.com/go-vtun/vtun/blob/main/README_CN.md)

[![Go Report Card](https://goreportcard.com/badge/github.com/go-vtun/vtun)](https://goreportcard.com/report/github.com/go-vtun/vtun)
![image](https://img.shields.io/badge/License-MIT-orange)
![image](https://img.shields.io/badge/License-Anti--996-red)
![image](https://img.shields.io/github/downloads/go-vtun/vtun/total.svg)

# Features
* VPN over udp
* VPN over websocket
* VPN over tls
* VPN over grpc
* VPN over quic
* VPN over kcp
* VPN over utls
* VPN over dtls
* VPN over h2
* VPN over http
* VPN over tcp
* VPN over https
# Usage

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

## Build

```
scripts/build.sh
```

## Client on Linux

```
sudo ./vtun-linux-amd64 -s server-addr:3001 -c 172.16.0.10/24 -k 123456

```

## Client on Linux with global mode(routing all your traffic to server)

```
sudo ./vtun-linux-amd64 -s server-addr:3001 -c 172.16.0.10/24 -k 123456 -g

```

## Client on MacOS

```
sudo ./vtun-darwin-amd64 -s server-addr:3001 -c 172.16.0.10/24 -k 123456 -g -sip 172.16.0.1

```

## Client on Windows
To use it with windows, you will need to download a [wintun.dll](https://www.wintun.net/) file in the app directory.  
Open powershell as administrator and run cmd:
```
.\vtun-win-amd64.exe  -s server-addr:3001 -c 172.16.0.10/24 -k 123456 -g -sip 172.16.0.1

```

## Server on Linux

```
sudo ./vtun-linux-amd64 -S -l :3001 -c 172.16.0.1/24 -k 123456

```

## Iptables setup on Linux server

```
  # Enable ipv4 and ipv6 forward
  vi /etc/sysctl.conf
  net.ipv4.ip_forward = 1
  net.ipv6.conf.all.forwarding=1
  sysctl -p /etc/sysctl.conf
  # Masquerade outgoing traffic
  iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
  iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
  # Allow return traffic
  iptables -A INPUT -i eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
  iptables -A INPUT -i tun0 -m state --state RELATED,ESTABLISHED -j ACCEPT
  # Forward everything
  iptables -A FORWARD -j ACCEPT


```

## How to build mobile libs


### 1. install gomobile
```
go install golang.org/x/mobile/cmd/gomobile@latest
gomobile init
```

### 2. install android [ndk](https://developer.android.com/studio/projects/install-ndk)


### 3. build android .aar file
```
make android
```


## Mobile client

### 1. GoFly VPN
<p>
<a href="https://play.google.com/store/apps/details?id=app.fjj.gofly"><img src="https://play.google.com/intl/en_us/badges/images/generic/en-play-badge.png" height="100"></a>
</p>

# License
[The MIT License (MIT)](https://raw.githubusercontent.com/go-vtun/vtun/main/LICENSE)

# Acknowledgments
Thanks [JetBrains](https://www.jetbrains.com/community/opensource/#support) for providing licenses.

<img src="https://resources.jetbrains.com/storage/products/company/brand/logos/jb_beam.png" alt="JetBrains Logo (Main) logo." width="100px">
