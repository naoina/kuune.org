+++
date = "2014-11-07T16:21:00+09:00"
draft = false
title = "Golangでどんな json が返ってくるかわからない時に struct で定義するまでじゃないんだけど､ interface だと呼び出しが面倒なのどうしたらいいんだろう問題への一回答例"
tags = ["go", "golang"]

+++

http://konboi.hatenablog.com/entry/2014/11/07/155418 これへの自分なりの回答です。元ブログのタイトルは const になってますが、多分 struct のことですかね。

Golang では `var` を使えば変数が定義できますが、このときに型を指定する必要があります。

```go
var name string
```

この型のところに struct を置いてやることができます。

```go
var user struct {
    Name string
    Age  int
}
```

よく考えればまぁできますよねという感じです。
これを応用すると、元ブログの例は下記のように書けます。

```go
package main

import (
    "bytes"
    "encoding/json"
    "fmt"
)

func main() {
    b := []byte(`{"foo": "bar", "hoge": {"fuga": "hoga"}}`)
    dec := json.NewDecoder(bytes.NewReader(b))
    var jsonData struct {
        Foo  string `json:"foo"`
        Hoge struct {
            Fuga string `json:"fuga"`
        } `json:"hoge"`
    }
    dec.Decode(&jsonData)
    fmt.Println(jsonData)
    fmt.Println(jsonData.Hoge.Fuga)

}
```

http://play.golang.org/p/nTCdrMxYoQ

ただしこの方法は本当にどんな内容が返ってくるか分からない時には使えない（例えば返ってくる json が {"foo": "bar"} なのか {"bar": "foo"} なのか分からない時など）のでその時は元の記事のように `interface{}` で受け取って型アサーションしてやる必要があります。
