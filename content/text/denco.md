+++
date = "2014-06-12T18:35:08+09:00"
draft = false
title = "世界最速だった URL ルーターをリリースしました"
tags = ["go", "golang", "denco"]

+++

Golang 用 URL ルーター [Denco](https://github.com/naoina/denco) をリリースしました。
ちょっと前までは最速でしたが、[HttpRouter](https://github.com/julienschmidt/httprouter) の作者によって高速にバックミラーから消し去られました。
ですが、HttpRouter ではできないことが Denco にできたりしますしおすし。
ベンチマークは https://github.com/julienschmidt/go-http-routing-benchmark からどうぞ。

## Denco とは

既に開発していた [kocha-urlrouter](https://github.com/naoina/kocha-urlrouter) のダブル配列実装をベースに色々と手を加えたものになります。
速度を重視して開発してましたが、前述の通り HttpRouter に追いぬかれました。

## 使い方

下記のように使います。

```go
router := denco.New()
router.Build([]denco.Record{
    {"/", "root"},
    {"/user/:id", 1024},
    {"/user/:name/:id", []string{"username"}},
    {"/static/*filepath", "static"},
})
data, params, found := router.Lookup("/")
fmt.Printf("%v\n", data.(string))
data, params, found = router.Lookup("/user/1")
fmt.Printf("%v, %v = %v\n", data.(int), params[0].Name, params[0].Value)
data, params, found = router.Lookup("/user/naoina/2")
fmt.Printf("%v\n", data.([]string))
for _, v := range params {
    fmt.Printf("%v = %v\n", v.Name, v.Value)
}
data, params, found = router.Lookup("/static/path/to/other")
fmt.Printf("%v, %v = %v\n", data, params[0].Name, params[0].Value)
```

README にも書いてあるんですが、Go の [http.ServeMux](http://golang.org/pkg/net/http/#ServeMux) を置き換えるものではないので、[http.Handler](http://golang.org/pkg/net/http/#Handler)  インターフェースは提供していません。
ですので、HandlerFunc などを呼ぶためのグルーコードを書く必要があります。

```go
package main

import (
    "fmt"
    "log"
    "net/http"

    "github.com/naoina/denco"
)

type handler struct {
    router *denco.Router
}

type handlerFunc func(http.ResponseWriter, *http.Request, []denco.Param)

func (h *handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
    m, params, found := h.router.Lookup(r.RequestURI)
    if !found {
        panic("route not found")
    }
    m.(handlerFunc)(w, r, params)
}

func Index(w http.ResponseWriter, r *http.Request, _ []denco.Param) {
    fmt.Fprint(w, "Welcome!\n")
}

func Hello(w http.ResponseWriter, r *http.Request, params []denco.Param) {
    fmt.Fprintf(w, "hello, %s!\n", params)
}

func main() {
    router := denco.New()
    if err := router.Build([]denco.Record{
        {"/", handlerFunc(Index)},
        {"/hello/naoina", handlerFunc(Hello)},
        {"/hello/:name", handlerFunc(Hello)},
    }); err != nil {
        panic(err)
    }
    h := &handler{router}
    log.Fatal(http.ListenAndServe(":8080", h))
}
```

これはそもそも [Kocha](https://github.com/naoina/kocha) で使うために書き始めたものなので上記のようになっています。

## vs HttpRouter

再び最速の座を手に入れるべく頑張っていますが、現状では HttpRouter とほぼダブルスコアです。。。社会は厳しい！
ですが、Denco にしかできないことがあります。
例えば、HttpRouter では `/user/:name` と `/user/naoina` など、パラメーター付きパスと静的パスがかぶるようなルートが一緒に使えず、構築時に panic するようになっていますが、Denco だと問題ありません。

```go
router.Build([]denco.Record{
    {"/user/:name", "first"},
    {"/user/naoina", "second"},
})
router.Lookup("/user/hoge") // "first"
router.Lookup("/user/foo") // "first"
router.Lookup("/user/naoina") // "second"
```

まぁ、負け惜しみです。

## まとめ

私が調べた限りだと、ダブル配列を使った URL ルーターの実装というものがありませんでした。
ですので、参考になるか分かりませんが、次回から Denco の技術解説みたいなのを書こうかなと考えています。
