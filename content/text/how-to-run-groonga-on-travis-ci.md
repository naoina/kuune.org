+++
date = "2013-08-03T18:35:25+09:00"
draft = false
title = "GroongaをTravis-CIで動かす方法"
aliases = ["/2013/08/03/183525518749/"]

+++

最近このブログに全文検索を付けるべく pyroonga の開発を再開しました、どうも私です。

さて、開発用リポジトリに GitHub をお使いの方は [Travis-CI](https://travis-ci.org/) を使っておられるかと思います。
pyroonga でも Travis-CI を使おうと思ったのですがそのままでは動かなかったので四苦八苦しながら動かしました。
最終的な `.travis.yml` は https://github.com/naoina/pyroonga/blob/develop/.travis.yml ですが、これに至るまでにハマったところを書いていきます。


## Travis-CI ではランタイムのバージョンを複数指定しても同じVM上で並列にテストが走る

初めにハマったのがこれです。Travis-CI を使うときは

```yaml
language: python
python:
 - "2.6"
 - "2.7"
 - "3.3"
```

のように複数バージョンを指定することがありますが、これらは同じ Travis-CI の VM 上で並列に実行されます。
どういうことかというと、普通に MySQL などのデータストレージを使ったテストを書いた場合、DB 名やテーブル名が同じだと更新や取得の結果が毎回変わり得るということです。
pyroonga の場合はテストケースごとに 「groonga データベースの作成 → groonga サーバー起動 → データベースの削除」ということをやっていたため、
並列で実行した場合にテスト結果が変わるという現象になりました。

対策としては、テーブル名を全てユニークにするなどしました。
また、groonga データベースの作成と groonga サーバーの起動は予め1回のみ行なってテストを走らせるという方式に変更しました。

## Groonga が起動しない

以下のように .travis.yml を書いていたら何故か groonga が起動しないという現象がありました。

```yaml
language: python
python:
 - "2.6"
 - "2.7"
 - "3.3"
before_install:
 - curl https://raw.github.com/groonga/groonga/master/data/travis/setup.sh | sh
before_script:
 - groonga -n /tmp/test.db quit
 - groonga -d /tmp/test.db
script: python setup.py testall
```

そこで、 groonga のログを出すように

```yaml
......
before_script:
 ......
 - groonga --log-path /tmp/groonga.log -d /tmp/test.db
 - cat /tmp/groonga.log
 ......
```

としてみました。するとログの中に

```
syscall error 'gethostbyname' (Success)
```

というものがありました。まぁ名前解決が出来てなくて起動できてないとわかったわけです。
ですので、最終的に

```yaml
......
- groonga -i localhost -d /tmp/test.db
......
```

というように修正して Travis-CI で Groonga を起動してのテストができるようになりました。

余談ですが、`groonga -d /tmp/test.db --log-path /tmp/groonga.log` などのように、`-d` や `-s` オプションの後に `--log-path` オプションを置くとログが出ない環境もありましたので、常に `--log-path` オプションを前に置くほうがいいです。（Arch Linux では出たが、Ubuntu 12.04 では出なかった）
