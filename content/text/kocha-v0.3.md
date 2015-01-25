+++
date = "2014-03-14T09:50:19+09:00"
draft = false
title = "Kocha が v0.3 になりました"
aliases = ["/2014/03/14/095019078664/"]

+++

`go get` でバージョン指定できないのにバージョン付ける意味あんのかよみたいな話はあると思いますが、Kocha https://github.com/naoina/kocha に v0.3 のタグを付けました。

主な変更点は

1. モデル、ORM、マイグレーションなどのデータベース周りのサポート
1. `dev` や `prod` などの環境ごとの設定の廃止

です。

## データベース周りのサポート

モデルのジェネレーターや ORM、マイグレーションのサポートを追加しました。
何故サポートなのかというと、Kocha 固有の ORM を使わないといけないわけではなく、自由に ORM が選べるような実装になっているからです。

### モデル

現状では [genmai](https://github.com/naoina/genmai) のみのサポートですが、簡単に他の ORM も追加できます。
モデルのジェネレーターも特定の ORM のものを追加できるようにしていますが、まだ他の ORM 用の実装はしていません。気が向いたら [gorp](https://github.com/coopernurse/gorp) 用ぐらいは実装すると思います。

    kocha g model user name:string age:int

みたいにすると

```go
type User struct {
    Id   int64  `db:"pk" json:"id"`
    Name string `json:"name"`
    Age  int    `json:"age"`

    genmai.TimeStamp
}
```

というような struct が書かれたファイルが生成されます。ついでに ORM 固有のインスタンスを取得するヘルパーが書かれたファイルも生成されます。
まぁここら辺に関してはドキュメント http://naoina.github.io/kocha/docs/model.html にあっさりですが書いています。

### マイグレーション

現時点で私が知っているマイグレーションツールといえば [goose](https://bitbucket.org/liamstask/goose) がありますが、ORM を使うときのデータベースの設定と、マイグレーションツールの設定が中身は同じなのに別々に管理しないといけないのが大変好ましくないと考えています。
ということで、フレームワーク側でマイグレーションをサポートしました。Rails みたいですね。

    kocha g migration create_user_table

でマイグレーションするためのファイルが生成されます。ですが、中身は自分で書かないといけません。Rails みたいにマイグレーション名から自動でマイグレーションの中身を記述するみたいなことはしない方向です。

    kocha migrate up

で前方向のマイグレーションが走ります。戻したい時は

    kocha migrate down

とすれば直近の 1 つのマイグレーションに対してロールバックする処理が走ります。まぁ実際の処理は全部ユーザー側で書かないといけないんですが。

## 環境ごとの設定の廃止

今まではアプリケーションのトップレベルディレクトリに `dev.go` や `prod.go`、`config/dev.go` や `config/prod.go` といった、いわゆる環境ごとの設定セットがありました。
今回の v0.3 からこれを廃止して、設定は基本的に環境変数によって実行時に指定するように変更しました。

    KOCHA_DB_DRIVER="mysql" KOCHA_DB_DSN="user:password@/dbname" kocha run

という感じになります。一応何も指定しない場合のデフォルトは sqlite3 が指定されてます。
この変更は [The Twelve-Factor App](http://12factor.net/) ([日本語訳](http://twelve-factor-ja.herokuapp.com/)) に影響されました。これの [config](http://12factor.net/config) ([日本語訳](http://twelve-factor-ja.herokuapp.com/config)) に沿った形にしたということになります。
余談ですが、WEB 系開発者はすべからく The Twelve-Factor App を読むべきだと思います。

## 今後の予定

ある程度なにか WEB サービスが作れそうなぐらいにはなってきたかなという感じです。
ですが、まだフォーム周りはまともに手を付けてないので、ここを何とかしたら自分自身でドッグフードを食べながらやっていこうかと考えています。
