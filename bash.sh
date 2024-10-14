#!/bin/bash
wget https://dl.google.com/go/go1.23.2.linux-amd64.tar.gz -O $HOME/go.tar.gz
tar -zxf $HOME/go.tar.gz
rm -rf $HOME/go.tar.gz
export GOROOT=$HOME/go
mkdir -p $HOME/golang
export GOPATH=$HOME/golang
export PATH=$GOROOT/bin:$PATH
go install golang.org/x/mobile/cmd/gomobile@latest
gomobile init
make all
env
