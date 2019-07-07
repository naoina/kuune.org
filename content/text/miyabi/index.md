+++
date = "2014-06-26T12:00:43+09:00"
draft = false
title = "Graceful shutdown と restart が出来る net/http コンパチのライブラリをつくった"
"text/tags" = ["go", "golang", "miyabi"]

+++

Miyabi
https://github.com/naoina/miyabi

Graceful shutdown/restart というのは HTTP サーバーにおいて、張られたソケットをいきなり切ってサーバーを終了するのではなく、すでに accept されているソケットに対する処理を終えてから終了または再起動することをいいます。
これによってダウンタイム無しでサーバーの再起動ができるようになります。

Golang には既に graceful shutdown/restart をするようなものが色々とありますが、Miyabi は `net/http` と完全に互換性があるように作っています。
なので、単に `http.ListenAndServe` を `miyabi.ListenAndServe` に変えるだけで graceful shutdown/restart が出来るようになります。

{{< img src="2776dcd1-afa7-5a35-9cc5-7cbacae1acf4.gif" alt="miyabi.gif" >}}

注意点として、graceful restart を実現するにあたってサーバープロセスをフォークするようになっています。起動する毎に副作用によって挙動が変わるようなモノだとまともに動かないのではないかと思います。
また、先日リリースされた Go 1.3 の機能を使っているので 1.2.x 以下では動作しません。みなさん既に Go 1.3 もしくは tip を使っているはずなので問題ないでしょう。

それでは、よい Golang 日和を。
