+++
date = "2013-11-12T23:57:53+09:00"
publishdate = "2013-11-12T23:57:53+09:00"
draft = false
title = "golang の net.TCPLister から file descriptor を取る"
tags = ["go", "golang"]

+++

何故かは分かりませんが、golang は net.TCPListener の file descriptor が export されていません。
通常は特に問題ないのですが、graceful restart を実装しようとした場合に困ったことになります。
ちなみに [`func (l *TCPListener) File() (f *os.File, err error)`](http://golang.org/pkg/net/#TCPListener.File) というのもありますが、これは file descriptor を複製するので graceful restart には使えません。（同じポートを Listen することになるため、複製の時点で bad file descriptor になる）

どうやって取るかというと、伝家の宝刀 reflect パッケージを使います。

```go
package main

import (
    "fmt"
    "net"
    "reflect"
)

func main() {
    addr, err := net.ResolveTCPAddr("tcp", "0.0.0.0:8000")
    if err != nil {
        panic(err)
    }
    listener, err := net.ListenTCP("tcp", addr)
    if err != nil {
        panic(err)
    }
    fdValue := reflect.Indirect(reflect.Indirect(reflect.ValueOf(listener)).FieldByName("fd"))
    fd := uintptr(fdValue.FieldByName("sysfd").Int())
    fmt.Println(fd)
}
```

この unexported なフィールドから取得するの、すごく気持ち悪いんですが他に方法ないんですかね。。。
