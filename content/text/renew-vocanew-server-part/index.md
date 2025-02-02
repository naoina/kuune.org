+++
date = "2013-09-22T21:16:52+09:00"
draft = false
title = "ぼかにゅーをリニューアルしました（サーバー編）"
"tags" = ["vocanew"]

+++

[前回](http://plog.la/naoina/2013/09/22/122917854959/) に引き続き今回は裏側の話です。

今回のリニューアルの動機は色々ありますが、一番は [Revel](http://robfig.github.io/revel/) を使ってみたかったからです。Powered by Golangです。


## 開発環境

今回の開発環境は Revel + Grunt + Bower で行いました。多少手を加えてますが https://github.com/naoina/revel-boilerplate と同じような構成になっています。
軽く説明すると、CSSはSCSSで書いてから [autoprefixer](https://github.com/ai/autoprefixer) を通ってコンパイル後にminify、JavaScriptはRequireJSを使って [almond](https://github.com/jrburke/almond) でRequireJSも含めて1ファイルにしてminifyします。これらはGruntタスクで行うので自動です。


## Revelについて

RevelはGo言語で書かれているWAFです。
フルスタックを謳っていますが、現在はまだフルスタックと言えるような感じではないので色々と自前で実装するかライブラリを引っ張ってくる必要があります。例えば、ORMやメール送信の処理などは現時点では無いです。
ぼかにゅーではRevelに加えてORMとして [gorp](https://github.com/coopernurse/gorp)、メール送信はGo言語標準ライブラリの [net/smtp](http://golang.org/pkg/net/smtp/) を使っています。
まぁgorpはORM-ishなので完全なORMではないですが。。。（SELECT文は生のSQLで書く必要があったりする）
また、RSSフィードの生成には [gorilla/feeds](https://github.com/gorilla/feeds) を使っています。


## 運用構成

よくある構成の、nginxからリバースプロキシでAppサーバーに繋ぐという構成です。キャッシュサーバーは今のところありません。


## 所感

現在はまだGo言語とRevelを使ってウェブサイトを作るのはオススメしません。DjangoやRailsなどの方が当然ですが断然便利です。
具体的には認証機構（Djangoのdjango.contrib.auth、Railsのdevise的なもの）が無いのと、Revelは標準でGo言語の `text/template` を使いますが、これはレイアウト的な機能が無いので使いづらいというのが大きいです。
また、Revelをデプロイするにはいくつか方法がありますが、ローカルビルドする場合サーバーと同様の環境を仮想マシンなどで構築しないと動作しなかったりします。（Arch上でビルドしてCentOS6に持って行ったらglibcのバージョンが合わずに動かなかった）

以上サーバー側の話でした。
今後はもしかしたらぼかにゅー自体のソースを公開するかもしないかも。
