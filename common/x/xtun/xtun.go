package xtun

import (
	"context"
	"github.com/go-vtun/vtun/common/config"
	"github.com/go-vtun/vtun/common/netutil"
	"github.com/go-vtun/vtun/common/x/xproto"
	"github.com/net-byte/water"
	"strings"
)

func ReadFromTun(iFace *water.Interface, config config.Config, out chan<- []byte, _ctx context.Context, _cancel context.CancelFunc) {
	defer _cancel()
	packet := make([]byte, config.BufferSize)
	for ContextOpened(_ctx) {
		n, err := iFace.Read(packet)
		if err != nil {
			netutil.PrintErr(err, config.Verbose)
			if strings.Contains(err.Error(), "file already closed") {
				break
			}
			continue
		}
		out <- xproto.Copy(packet[:n])
	}
}

func WriteToTun(iFace *water.Interface, config config.Config, in <-chan []byte, _ctx context.Context, _cancel context.CancelFunc) {
	defer _cancel()
	for ContextOpened(_ctx) {
		b := <-in
		_, err := iFace.Write(b)
		if err != nil {
			netutil.PrintErr(err, config.Verbose)
			if strings.Contains(err.Error(), "file already closed") {
				break
			}
			continue
		}
	}
}

func ContextOpened(_ctx context.Context) bool {
	select {
	case <-_ctx.Done():
		return false
	default:
		return true
	}
}
