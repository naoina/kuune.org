+++
title = "Migu v0.2.0をリリースしました"
date = 2017-11-19T14:05:49+09:00
draft = false
"text/tags" = ["go", "golang", "migu"]
logo = ""
logosmall = ""
+++

最近新しくサービスを作ろうとしてまして、そのサービスのデータベースのスキーマ管理にMiguを使おうとしました。しかし、あまりにも機能が足りていなくて困ったのでYak shavingした結果、Miguを大幅に改良し、0.2.0として約2年越しにリリースしました。リリースと言ってもタグ付けただけですが。

https://github.com/naoina/migu

MiguについてはリポジトリのREADMEか、[以前の記事]({{< relref "migu/index.md" >}})を見てください。

## //+migu が必須になった

Migu 0.2.0ではstructのコメントに`+migu`というアノテーションがあるstructのみをスキーマとして扱うようになりました。今までのMiguはGoのstructすべてをスキーマとして扱っていました。

```go
//+migu
type User struct {
    Name string
}

type Admin struct {
    Name string
}
```

この例の場合、Miguは`User` structをスキーマとみなしますが、`Admin` structは単に無視します。

## CLIの対象にディレクトリを指定できるようになった

Migu 0.2.0ではディレクトリが指定できるようになりました。ディレクトリが指定された場合はその中にあるファイルがスキーマとして扱われます。

```bash
migu sync test_db model/
```

今までのMiguは`schema.go`のような単一ファイルにすべてのスキーマを書くことを前提としていました。しかし、実際にモデルを書くときには`model/user.go`や`model/entry.go`のような複数のファイルに分けたりします。複数のファイルをスキーマとしてMiguに食わせたい場合、シェルの`for-in`などを使う必要がありました。

```bash
for file in model/*.go; do migu sync test_db $file; done
```

## カラム名を指定できるようになった

Migu 0.2.0では`column`タグを使うことによってカラム名を指定できます。

```go
//+migu
type User struct {
    EmailAddress string `migu:"column:email"`
}
```

```sql
CREATE TABLE `user` (
  `email` VARCHAR(255) NOT NULL
)
```

今までのMiguはGoのstructのフィールド名だけを使ってデータベーステーブルのカラム名を決定していました。

```go
//+migu
type User struct {
    EmailAddress string
}
```

このようなstructがあった場合、Miguは`EmailAddress`というフィールドを`email_address`というデータベーステーブルのカラム名にマッピングします。

```sql
CREATE TABLE `user` (
  `email_address` VARCHAR(255) NOT NULL
)
```

今まではこのカラム名を指定する方法がありませんでしたが、Migu 0.2.0では`columns`タグにより解決しています。

## インデックスのサポート

Migu 0.2.0では`index`タグを使うことによりインデックスもMiguで管理できるようになりました。

```go
//+migu
type User struct {
    Email string `migu:"index"`
}
```

また、インデックスに好きな名前を付けることもできます。

```go
//+migu
type User struct {
    Email string `migu:"index:user_email_index"`
}
```

複数のフィールドに同じインデックス名を付けると複合インデックスにできます。

```go
//+migu
type User struct {
    Name  string `migu:"index:name_email_index"`
    Email string `migu:"index:name_email_index"`
}
```

同様に、ユニークインデックスにも名前が付けられるようになりました。もちろん複合ユニークインデックスにも対応しています。

```go
//+migu
type User struct {
    Name  string `migu:"unique:name_email_unique_index"`
    Email string `migu:"unique:name_email_unique_index"`
}
```

今までのMiguにはインデックスを作成したり削除したりといったSQLを生成できなかったので、手動でSQLを発行する必要がありました。

## Extraフィールドのサポート

Migu 0.2.0では `_` という特別なフィールドを使ってカラムを定義できるようになりました。

```go
type Timestamp struct {
    CreatedAt time.Time
    UpdatedAt time.Time
}

//+migu
type User struct {
    Name string
    Timestamp
    _ time.Time `migu:"column:created_at"`
    _ time.Time `migu:"column:updated_at"`
}
```

Miguは埋め込みフィールドを上手く扱えません。これは、MiguがASTを通してstructを解析しているところからくる制限です。GoのORMの中には埋め込みフィールドを扱えるものがあります。例えば次のようなstruct定義では、`CreatedAt`と`UpdatedAt`をstructとして切り出し、他のstructに埋め込むことによりstructごとに`CreatedAt`と`UpdatedAt`を定義しなくていいようにしています。

```go
type Timestamp struct {
    CreatedAt time.Time
    UpdatedAt time.Time
}

//+migu
type User struct {
    Name string
    Timestamp
}
```

ASTでは`Timestamp`というフィールドが`CreatedAt`と`UpdatedAt`というフィールドを持っていることがわかりません。これはASTがパッケージやファイルを超えた依存関係が解決できないからです。Extraフィールドのサポートはこの問題に対するひとつの回避策です。

きちんと埋め込みフィールドをサポートしたいところなのですが、埋め込みフィールドをサポートしようとすると、どうしても`reflect`を使わざるを得なく、`reflect`を使う場合は一旦ビルドする必要があり、`GOPATH`や`import`するパッケージの解決などを考えると、やはり難しいと考えています。もっといいアイデアがあれば教えてください。

## テーブルオプションのサポート

Migu 0.2.0では、データベースのテーブル名や作成時に指定できるオプションを指定できるようになりました。

```go
//+migu table:"guest" option:"ROW_FORMAT = DYNAMIC"
type User struct {
    Name string
}
```

当初はこれが欲しくてMiguの開発を再開しました。utf8mb4 + VARCHARの最大文字数問題を回避するために`ROW_FORMAT = DYNAMIC`を付けたかっただけですが、ひとつ気になると別の場所も気になって、あれよあれよと改良してしまったという経緯があります。

## その他

### PostgreSQLやSQLite3サポートについて

私自身では対応しない方針です。これは、私が基本的にMariaDB/MySQLしか使わないためメンテナンスができないという理由によるものです。PostgreSQLやSQLite3サポートについてはプルリクエストをもらったら考えます。
