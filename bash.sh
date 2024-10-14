#!/bin/bash
wget https://dl.google.com/go/go1.23.2.linux-amd64.tar.gz -O $GITHUB_WORKSPACE/go.tar.gz
tar -zxf $GITHUB_WORKSPACE/go.tar.gz
rm -rf $GITHUB_WORKSPACE/go.tar.gz
export GOROOT=$GITHUB_WORKSPACE/go
mkdir -p $GITHUB_WORKSPACE/golang
export GOPATH=$GITHUB_WORKSPACE/golang
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH
go install golang.org/x/mobile/cmd/gomobile@latest
gomobile init
go get golang.org/x/mobile/bind
make android
env
ls
