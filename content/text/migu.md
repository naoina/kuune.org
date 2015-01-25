+++
date = "2014-10-29T17:53:44+09:00"
draft = false
title = "Migu という golang 用 DB スキーマのマイグレーションツールを作った話"
aliases = ["/2014/10/29/175344838688/"]

+++

[Ridgepole](https://github.com/winebarrel/ridgepole) インスパイアの golang 用 DB スキーマのマイグレーションツールを作りました。

https://github.com/naoina/migu

Migu は Ridgepole と同様に（バグが無い限り）冪等性が保証されています。
Ridgepole と違うところは、スキーマ定義を DSL ではなくて golang の struct で定義するところです。こうすることによって、モデル定義 ＝ スキーマ定義となるので DRY になります。

## 使い方

下記を `schema.go` というファイル名で保存します。ファイル名は何でもいいんですが、ここでは `schema.go` を使います。package 名も何でも構いません。

```go
package schema

type User struct {
    Name string
    Age  int
}
```

次に `migu_test` というデータベースを `mysqladmin` コマンドで作成します。

```bash
mysqladmin -u root create migu_test
```

ここでは MySQL のパスワード無しの `root` ユーザーでログインすることを想定しています。
データベースを作成したら `migu` コマンドでマイグレーションを実行します。

```bash
migu -u root sync migu_test schema.go
```

実行した結果、下記のように `migu_test` に `user` テーブルが作成されます。

```bash
% mysql -u root migu_test -e 'desc user'
+-------+--------------+------+-----+---------+-------+
| Field | Type         | Null | Key | Default | Extra |
+-------+--------------+------+-----+---------+-------+
| name  | varchar(255) | NO   |     | NULL    |       |
| age   | int(11)      | NO   |     | NULL    |       |
+-------+--------------+------+-----+---------+-------+
```

ではここから更に Migu のマイグレーションを試していきます。
先ほどの `schema.go` を下記のように変更します。

```go
package schema

type User struct {
    Name string
    Age  uint
}
```

`Age int` を `Age uint` に変えました。
では再度 `migu` コマンドでマイグレーションを実行して結果を確認します。

```bash
% migu -u root sync migu_test schema.go
% mysql -u root migu_test -e 'desc user'
+-------+------------------+------+-----+---------+-------+
| Field | Type             | Null | Key | Default | Extra |
+-------+------------------+------+-----+---------+-------+
| name  | varchar(255)     | NO   |     | NULL    |       |
| age   | int(10) unsigned | NO   |     | NULL    |       |
+-------+------------------+------+-----+---------+-------+
```

`age` フィールドが `int(11)` から `int(10) unsigned` に変わっているのが分かるでしょうか？
このように、Migu ではスキーマ定義を変えてコマンドを実行すればマイグレーションができます。今までのようにマイグレーション用 SQL を書く必要はありません。
また、Migu の冪等性を確認するためにもう一度マイグレーションを実行してみます。

```bash
% migu -u root sync migu_test schema.go
% mysql -u root migu_test -e 'desc user'
+-------+------------------+------+-----+---------+-------+
| Field | Type             | Null | Key | Default | Extra |
+-------+------------------+------+-----+---------+-------+
| name  | varchar(255)     | NO   |     | NULL    |       |
| age   | int(10) unsigned | NO   |     | NULL    |       |
+-------+------------------+------+-----+---------+-------+
```

変わっていませんね。

ちなみに golang は同じパッケージ内であれば struct 本体とメソッドが別々のファイルにあってもいいので、下記のようにスキーマ定義とモデルの実装を分離することができます。

```go
// schema.go
type User struct {
    Name string
    Age  int
}
```

```go
// user.go
func (u *User) IsAlice() bool {
    return u.Name == "alice"
}
```

## まとめ

Migu を使うことで大量のマイグレーションファイルを書く必要が無くなり、DB スキーマの管理が非常に楽になる上に身長が 5 センチ伸び、恋人もできることがお分かりいただけたかと思います。
とはいえ、まだまだ粗削りで足りない部分も多いので、これからもっと改良していく必要があります。
というわけで、あなたの Pull Request をお待ちしております。
