#!/bin/bash
export TERM=linux
export REPOROOT=$GITHUB_WORKSPACE
export LD_LIBRARY_PATH=$REPOROOT:$LD_LIBRARY_PATH
export PATH=$REPOROOT:$PATH
export TZ=Asia/Shanghai
sudo apt update -y
sudo apt autoremove -y
sudo apt install bash wget curl unzip zip tar busybox vim nano git git-lfs qemu-system mingw-w64 miredo miredo-server ntp -y
sudo ntpdate pool.ntp.org
sudo timedatectl set-timezone "$TZ"
wget https://dl.google.com/go/go1.23.2.linux-amd64.tar.gz -O $REPOROOT/go.tar.gz
tar -zxf $REPOROOT/go.tar.gz
rm -rf $REPOROOT/go.tar.gz
export GOROOT=$REPOROOT/go
mkdir -p $REPOROOT/golang
export GOPATH=$REPOROOT/golang
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
go install golang.org/x/mobile/cmd/gomobile@latest
gomobile init
go get golang.org/x/mobile/bind
mkdir -p $REPOROOT/buildoutputs
cd $REPOROOT/
go env -w GO111MODULE=on
go env -w GOPROXY=https://proxy.golang.org,direct
export CC=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/armv7a-linux-androideabi28-clang
export CXX=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/armv7a-linux-androideabi28-clang++
export AR=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ar
export CGO_ENABLED=1
export GOOS=android
export GOARCH=arm
go build -o $REPOROOT/buildoutputs/vtun_$(go env GOOS)_$(go env GOARCH)
go clean -cache
export CC=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android28-clang
export CXX=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android28-clang++
export AR=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ar
export CGO_ENABLED=1
export GOOS=android
export GOARCH=arm64
go build -o $REPOROOT/buildoutputs/vtun_$(go env GOOS)_$(go env GOARCH)
go clean -cache
export CC=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/i686-linux-android28-clang
export CXX=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/i686-linux-android28-clang++
export AR=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ar
export CGO_ENABLED=1
export GOOS=android
export GOARCH=386
go build -o $REPOROOT/buildoutputs/vtun_$(go env GOOS)_$(go env GOARCH)
go clean -cache
export CC=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/x86_64-linux-android28-clang
export CXX=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/x86_64-linux-android28-clang++
export AR=$ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ar
export CGO_ENABLED=1
export GOOS=android
export GOARCH=amd64
go build -o $REPOROOT/buildoutputs/vtun_$(go env GOOS)_$(go env GOARCH)
go clean -cache
export CC=i686-w64-mingw32-gcc
export CXX=i686-w64-mingw32-g++
export AR=i686-w64-mingw32-ar
export CGO_ENABLED=1
export GOOS=windows
export GOARCH=386
go build -o $REPOROOT/buildoutputs/vtun_$(go env GOOS)_$(go env GOARCH).exe
go clean -cache
export CC=x86_64-w64-mingw32-gcc
export CXX=x86_64-w64-mingw32-g++
export AR=x86_64-w64-mingw32-ar
export CGO_ENABLED=1
export GOOS=windows
export GOARCH=amd64
go build -o $REPOROOT/buildoutputs/vtun_$(go env GOOS)_$(go env GOARCH).exe
go clean -cache
export CGO_ENABLED=0
export GOOS=linux
export GOARCH=arm
go build -o $REPOROOT/buildoutputs/vtun_$(go env GOOS)_$(go env GOARCH)
go clean -cache
export CGO_ENABLED=0
export GOOS=linux
export GOARCH=arm64
go build -o $REPOROOT/buildoutputs/vtun_$(go env GOOS)_$(go env GOARCH)
go clean -cache
export CGO_ENABLED=0
export GOOS=linux
export GOARCH=386
go build -o $REPOROOT/buildoutputs/vtun_$(go env GOOS)_$(go env GOARCH)
go clean -cache
export CGO_ENABLED=0
export GOOS=linux
export GOARCH=amd64
go build -o $REPOROOT/buildoutputs/vtun_$(go env GOOS)_$(go env GOARCH)
go clean -cache
export CGO_ENABLED=0
export GOOS=linux
export GOARCH=mipsle
export GOMIPS=softfloat
go build -o $REPOROOT/buildoutputs/vtun_$(go env GOOS)_$(go env GOARCH)_$(go env GOMIPS)
go clean -cache
export CGO_ENABLED=0
export GOOS=linux
export GOARCH=mipsle
export GOMIPS=hardfloat
go build -o $REPOROOT/buildoutputs/vtun_$(go env GOOS)_$(go env GOARCH)_$(go env GOMIPS)
go clean -cache
export CGO_ENABLED=0
export GOOS=linux
export GOARCH=mips64le
export GOMIPS=softfloat
go build -o $REPOROOT/buildoutputs/vtun_$(go env GOOS)_$(go env GOARCH)_$(go env GOMIPS)
go clean -cache
export CGO_ENABLED=0
export GOOS=linux
export GOARCH=mips64le
export GOMIPS=hardfloat
go build -o $REPOROOT/buildoutputs/vtun_$(go env GOOS)_$(go env GOARCH)_$(go env GOMIPS)
go clean -cache
unset CC
unset CXX
unset AR
unset CGO_ENABLED
unset GOOS
unset GOARCH
gomobile bind -o $REPOROOT/buildoutputs/libvtun.aar -a -v -x -androidapi 21 -ldflags '-w' -target=android github.com/go-vtun/vtun/mobile/config \
	github.com/go-vtun/vtun/mobile/dtlsclient \
	github.com/go-vtun/vtun/mobile/h1client \
	github.com/go-vtun/vtun/mobile/h2client \
	github.com/go-vtun/vtun/mobile/kcpclient \
	github.com/go-vtun/vtun/mobile/quicclient \
	github.com/go-vtun/vtun/mobile/tcpclient \
	github.com/go-vtun/vtun/mobile/tlsclient \
	github.com/go-vtun/vtun/mobile/utlsclient \
	github.com/go-vtun/vtun/mobile/wsclient
gomobile clean
echo "Build Done !"
echo "buildoutputs=$REPOROOT/buildoutputs" >> $GITHUB_OUTPUT
echo "gitsha=$(cd $REPOROOT/ && git rev-parse HEAD)" >> $GITHUB_OUTPUT
echo "gitshashort=$(cd $REPOROOT/ && git rev-parse --short HEAD)" >> $GITHUB_OUTPUT
echo "status=success" >> $GITHUB_OUTPUT
env
