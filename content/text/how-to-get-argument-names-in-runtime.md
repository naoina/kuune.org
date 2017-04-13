+++
date = "2013-10-21T23:40:16+09:00"
publishdate = "2013-10-21T23:40:16+09:00"
draft = false
title = "golangで実行時に関数の引数の名前を取得する方法"
tags = ["go", "golang"]

+++

golang には `reflect` というリフレクションライブラリがありますが、これは関数の引数の情報は型までしか取れないため、引数の名前が欲しい場合は使えません。

```go
package main

import (
    "fmt"
    "reflect"
)

func A(id int) {}

func main() {
    aFunc := reflect.TypeOf(A)
    for i := 0; i < aFunc.NumIn(); i++ {
        fmt.Println(aFunc.In(i).String()) // int
        fmt.Println(aFunc.In(i).Kind())   // int
        fmt.Println(aFunc.In(i).Name())   // int
    }
}
```
http://play.golang.org/p/l8bIUKSFXL

では引数の名前も含めて取得したい場合はどうするかというと、`go/parser` と `go/ast` 使います。

```go
package main

import (
    "go/ast"
    "go/parser"
    "go/token"
)

func main() {
    src := `
package main
func A(id int) {}
`
    fset := token.NewFileSet()
    f, err := parser.ParseFile(fset, "", src, 0)
    if err != nil {
        panic(err)
    }
    for _, decl := range f.Decls {
        ast.Inspect(decl, func(node ast.Node) bool {
            fn, ok := node.(*ast.FuncDecl)
            if !ok {
                return false
            }
            fnName := fn.Name.Name
            for _, param := range fn.Type.Params.List {
                typeName := param.Type.(*ast.Ident).Name
                for _, name := range param.Names {
                    println(fnName, name.Name, typeName) // A id int
                }
            }
            return false
        })
    }
}
```
http://play.golang.org/p/5B7kAf-v-Y

ただしこの方法の場合、golang のソースファイルかその内容の文字列が必要になるのでバイナリだけでは達成出来ないのが難です。
