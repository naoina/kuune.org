+++
date = "2014-02-17T12:17:43+09:00"
draft = false
title = "おれのかんがえたさいきょうの ORM for Golang"
"tags" = ["go", "golang", "genmai", "orm"]

+++

既存の ORM はその ORM 独自の記法なりメソッド（Find とか Save とか）がどういう SQL 相当のものなのかを覚える必要がある。
また、各 ORM ごとにそれが異なるため潰しが効かない。だけど [gorp](https://github.com/coopernurse/gorp) のように SQL を文字列で書きたいわけじゃない。
ということで作った。

Genmai https://github.com/naoina/genmai

ORM というよりはクエリビルダーに近いので、SQL に耐性のない者は死ぬ。

## 使い方

まずテーブルを定義して

```go
package main

import (
    "fmt"

    _ "github.com/mattn/go-sqlite3"
    "github.com/naoina/genmai"
)

type User struct {
    Id   int64  `db:"pk"`
    Name string `default:""`
}
```

テーブルをデータベース上に作成する。

```go
db, err := genmai.New(&genmai.SQLite3Dialect{}, ":memory:")
if err != nil {
    panic(err)
}
// CREATE TABLE IF NOT EXISTS "user" (
//     "id" integer PRIMARY KEY AUTOINCREMENT,
//     "name" text
// );
if err := db.CreateTableIfNotExists(&User{}); err != nil {
    panic(err)
}
```

レコードをデータベースに入れて

```go
records := []User{
    {Name: "alice"},
    {Name: "bob"},
}
// INSERT INTO "user" ("name") VALUES ("alice"), ("bob");
if _, err := db.Insert(records); err != nil {
    panic(err)
}
```

入れたデータを取り出す。

```go
var users []User
// SELECT "user".* FROM "user";
if err := db.Select(&users); err != nil {
    panic(err)
}
fmt.Printf("%v\n", users)
// Output: [{1 alice} {2 bob}]
```

`Select` の条件を指定する場合は `db.Where` が使える。

```go
var users []User
// SELECT "user".* FROM "user" WHERE "user"."id" = 1;
if err := db.Select(&users, db.Where("id", "=", 1)); err != nil {
    panic(err)
}
fmt.Printf("%v\n", users)
// Output: [{1 alice}]
```

他にもひと通り基本的な SQL の句に対応していて、[README.md](https://github.com/naoina/genmai/blob/master/README.md) や [Examples](http://godoc.org/github.com/naoina/genmai#pkg-examples) 見るのが早いです。

現状はこういう API が良いと思って実装してるけど、Rails みたいなもっとリッチな ORM が欲しくなったらこれの上に構築すると思う。

## 余談

これ完全に [Kocha](https://github.com/naoina/kocha) のモデルレイヤーのために作った。Kocha (紅**茶**) だから Genmai (玄米**茶**)。
