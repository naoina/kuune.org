+++
date = "2014-07-24T10:56:39+09:00"
draft = false
title = "Kocha v0.5 リリースしました"
tags = ["go", "golang", "kocha"]

+++

https://github.com/naoina/kocha

前のバージョンとは非互換になってます。というか v1.0 まではバンバン非互換の変更入れていくつもりなので、まともに使うのはオススメしません。
ですが、もしそれでも Kocha を使いたいという場合は、人柱になって最新のバージョンを追いつつ使うか、[gopkg.in](http://labix.org/gopkg.in) を使ったりしてバージョンを固定して使うことをおすすめします。

## v0.5 での変更点

### URL ルーターを denco にしました

以前までの URL ルーターを別に切り出して改良した [Denco](https://github.com/naoina/denco) を使うようにしました。
これにより URL ルーティングのパフォーマンスが上がり、メモリ使用量も大幅に改善されています。

### net/http 互換として使えるようになりました

今までは Kocha で作ったものは Kocha でしか動かせませんでしたが、内外的に大幅に変更を加えて [http.Handler](http://golang.org/pkg/net/http/#Handler) インターフェースを実装しました。
これによって他の `net/http` 用ライブラリ（ミドルウェアとして処理を挟むものなど）と組み合わせて使えるようになりました。
これは http://naoina.github.io/kocha/docs/advanced.html に軽く書いています。
なお v0.5 における非互換性は大体この変更のせいです。

### Go 1.3 以降のみをサポートします

golang はどんどん開発が進んでいるので敢えて古いものを使う必要は今のところ無いので新しいもの使っていきましょう。

というのは建前で、実際のところは Kocha の graceful restart の機能を [miyabi](https://github.com/naoina/miyabi) というライブラリとして再実装し直して Kocha で使っているのですが、この miyabi が Go 1.3 で `net/http` に導入された機能を使っているからです。

## 今後の予定

ログ周りの再設計をします。後は session による flash 機構の実装をしようと思います。
そこまでできたら [ぼかにゅー](http://vocanew.kuune.org) や、この plog.la を Kocha で実装して、実際に使う際に必要な機能やデバッグをしていこうと考えています。
