#!/bin/bash
export TERM=linux
export REPOROOT=$GITHUB_WORKSPACE
export LD_LIBRARY_PATH=$REPOROOT:$LD_LIBRARY_PATH
export PATH=$REPOROOT:$PATH
export TZ=Asia/Shanghai
sudo apt update -y
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt install bash wget curl unzip zip tar busybox vim nano git python qemu-system mingw-w64 nodejs python3 miredo miredo-server ntpdate -y
sudo ntpdate pool.ntp.org
sudo timedatectl set-timezone "$TZ"
wget https://dl.google.com/android/repository/android-ndk-r21b-linux-x86_64.zip -O $REPOROOT/ndk.zip
unzip $REPOROOT/ndk.zip
rm -rf $REPOROOT/ndk.zip
export ANDROID_NDK_ROOT=$REPOROOT/android-ndk-r21b
$ANDROID_NDK_ROOT/build/tools/make-standalone-toolchain.sh --install-dir=$REPOROOT/android/arm --arch=arm --platform=android-28
$ANDROID_NDK_ROOT/build/tools/make-standalone-toolchain.sh --install-dir=$REPOROOT/android/arm64 --arch=arm64 --platform=android-28
$ANDROID_NDK_ROOT/build/tools/make-standalone-toolchain.sh --install-dir=$REPOROOT/android/x86 --arch=x86 --platform=android-28
$ANDROID_NDK_ROOT/build/tools/make-standalone-toolchain.sh --install-dir=$REPOROOT/android/x86_64 --arch=x86_64 --platform=android-28
export PATH=$ANDROID_NDK_ROOT:$REPOROOT/android/arm/bin:$REPOROOT/android/arm64/bin:$REPOROOT/android/x86/bin:$REPOROOT/android/x86_64/bin:$PATH
wget https://dl.google.com/go/go1.23.2.linux-amd64.tar.gz -O $REPOROOT/go.tar.gz
tar -zxf $REPOROOT/go.tar.gz
rm -rf $REPOROOT/go.tar.gz
export GOROOT=$REPOROOT/go
mkdir -p $REPOROOT/golang
export GOPATH=$REPOROOT/golang
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
mkdir -p $REPOROOT/buildgostout
cd $REPOROOT/gost/cmd/gost
go env -w GO111MODULE=on
go env -w GOPROXY=https://proxy.golang.org,direct
export CC=arm-linux-androideabi-gcc
export CXX=arm-linux-androideabi-g++
export AR=arm-linux-androideabi-ar
export CGO_ENABLED=1
export GOOS=android
export GOARCH=arm
go build -o $REPOROOT/buildgostout/gost_$(go env GOOS)_$(go env GOARCH)
go clean -cache
export CC=aarch64-linux-android-gcc
export CXX=aarch64-linux-android-g++
export AR=aarch64-linux-android-ar
export CGO_ENABLED=1
export GOOS=android
export GOARCH=arm64
go build -o $REPOROOT/buildgostout/gost_$(go env GOOS)_$(go env GOARCH)
go clean -cache
export CC=i686-linux-android-gcc
export CXX=i686-linux-android-g++
export AR=i686-linux-android-ar
export CGO_ENABLED=1
export GOOS=android
export GOARCH=386
go build -o $REPOROOT/buildgostout/gost_$(go env GOOS)_$(go env GOARCH)
go clean -cache
export CC=x86_64-linux-android-gcc
export CXX=x86_64-linux-android-g++
export AR=x86_64-linux-android-ar
export CGO_ENABLED=1
export GOOS=android
export GOARCH=amd64
go build -o $REPOROOT/buildgostout/gost_$(go env GOOS)_$(go env GOARCH)
go clean -cache
export CC=i686-w64-mingw32-gcc
export CXX=i686-w64-mingw32-g++
export AR=i686-w64-mingw32-ar
export CGO_ENABLED=1
export GOOS=windows
export GOARCH=386
go build -o $REPOROOT/buildgostout/gost_$(go env GOOS)_$(go env GOARCH).exe
go clean -cache
export CC=x86_64-w64-mingw32-gcc
export CXX=x86_64-w64-mingw32-g++
export AR=x86_64-w64-mingw32-ar
export CGO_ENABLED=1
export GOOS=windows
export GOARCH=amd64
go build -o $REPOROOT/buildgostout/gost_$(go env GOOS)_$(go env GOARCH).exe
go clean -cache
export CGO_ENABLED=0
export GOOS=linux
export GOARCH=arm
go build -o $REPOROOT/buildgostout/gost_$(go env GOOS)_$(go env GOARCH)
go clean -cache
export CGO_ENABLED=0
export GOOS=linux
export GOARCH=arm64
go build -o $REPOROOT/buildgostout/gost_$(go env GOOS)_$(go env GOARCH)
go clean -cache
export CGO_ENABLED=0
export GOOS=linux
export GOARCH=386
go build -o $REPOROOT/buildgostout/gost_$(go env GOOS)_$(go env GOARCH)
go clean -cache
export CGO_ENABLED=0
export GOOS=linux
export GOARCH=amd64
go build -o $REPOROOT/buildgostout/gost_$(go env GOOS)_$(go env GOARCH)
go clean -cache
export CGO_ENABLED=0
export GOOS=linux
export GOARCH=mipsle
export GOMIPS=softfloat
go build -o $REPOROOT/buildgostout/gost_$(go env GOOS)_$(go env GOARCH)_$(go env GOMIPS)
go clean -cache
export CGO_ENABLED=0
export GOOS=linux
export GOARCH=mipsle
export GOMIPS=hardfloat
go build -o $REPOROOT/buildgostout/gost_$(go env GOOS)_$(go env GOARCH)_$(go env GOMIPS)
go clean -cache
export CGO_ENABLED=0
export GOOS=linux
export GOARCH=mips64le
export GOMIPS=softfloat
go build -o $REPOROOT/buildgostout/gost_$(go env GOOS)_$(go env GOARCH)_$(go env GOMIPS)
go clean -cache
export CGO_ENABLED=0
export GOOS=linux
export GOARCH=mips64le
export GOMIPS=hardfloat
go build -o $REPOROOT/buildgostout/gost_$(go env GOOS)_$(go env GOARCH)_$(go env GOMIPS)
go clean -cache
echo "Build Gost Done !"
echo "::set-output name=buildgostout::$REPOROOT/buildgostout"
echo "::set-output name=gostsrc::$REPOROOT/gost/"
echo "::set-output name=gostgitsha::$(cd $REPOROOT/gost/ && git rev-parse HEAD)"
echo "::set-output name=gostgitshashort::$(cd $REPOROOT/gost/ && git rev-parse --short HEAD)"
echo "::set-output name=status::success"


go install golang.org/x/mobile/cmd/gomobile@latest
gomobile init
go get golang.org/x/mobile/bind
make android
env
