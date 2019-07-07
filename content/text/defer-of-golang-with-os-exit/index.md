+++
date = "2013-10-17T12:57:11+09:00"
draft = false
title = "golangのdeferはos.Exitした場合は実行されない件"
"text/tags" = ["go", "golang"]

+++

golang の `defer` はてっきり(関数/メソッド)を抜けた際に必ず実行されるものだと思っていたが、どうやら違うらしい。

http://golang.org/ref/spec#Defer_statements

```text
A "defer" statement invokes a function whose execution is deferred to the moment the surrounding function returns, either because the surrounding function executed a return statement, reached the end of its function body, or because the corresponding goroutine is panicking.
```

要は関数からreturnした場合、関数の終わりに達した場合、または panic した場合だけ `defer` が実行されるらしい。

例えば下記のコードの場合 *start* しか出力されない。
http://play.golang.org/p/nU-neWPUiR

```
package main

import "os"

func main() {
    defer println("hook exit")
    println("start")
    os.Exit(0)
    println("end")
}
```

```text
start
```
