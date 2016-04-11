+++
date = "2013-12-16T23:05:02+09:00"
draft = false
title = "Kocha における URL ルーターの実装と予定"
tags = ["go", "golang", "kocha"]

+++

現在、[Kocha](https://github.com/naoina/kocha) における URL ルーター(`/path/to/controller` とかの URL を特定のコントローラーにルーティングするアレ)の実装は素朴な実装で、ルートごとの正規表現を配列に持っていて、頭から順番にループを回して一致するものを探すようになっている。
非常に簡単な仕組みだが、O(N)なのでルートが増えると遅くなる。そこで下記の記事にあるような全部のルートを 1 つの正規表現でマッチさせる実装を試した。

http://r7kamura.github.io/2013/11/27/rack-multiplexer.html

結果は、ループを回す方法の約 7 倍程度 **遅く** なった。Ruby だと 17 倍ほど速くなるものが Golang だと 7 倍遅くなってしまった。
泣きながらググったところ、golang の正規表現は Ruby や Python のそれとは違う方式なのと、Pure Go で実装してるから〜みたいな話っぽい。

https://groups.google.com/forum/#!topic/golang-nuts/6d1maef4jQ8
http://golang.org/doc/faq#Why_does_Go_perform_badly_on_benchmark_x

さらに調べたら下記の記事が見つかった。

http://blog.ant0ine.com/typepad/2013/02/better-url-routing-golang-1.html

[Trie](http://ja.wikipedia.org/wiki/%E3%83%88%E3%83%A9%E3%82%A4%E6%9C%A8) を使ったらめっちゃ速くなったわー。らしい。
というわけで、Trie 関連の調査を開始して、[Trie](http://ja.wikipedia.org/wiki/%E3%83%88%E3%83%A9%E3%82%A4%E6%9C%A8) → [Patricia tree](http://ja.wikipedia.org/wiki/%E5%9F%BA%E6%95%B0%E6%9C%A8) → [Ternary Search Tree](http://ja.wikipedia.org/wiki/%E4%B8%89%E5%88%86%E6%8E%A2%E7%B4%A2%E6%9C%A8) → [LOUDS](http://d.hatena.ne.jp/takeda25/20120303/1330760254) → [Double Array](http://nanika.osonae.com/DArray/dary.html) ←ｲﾏｺｺ
という状況です。
とりあえず Kocha の URL ルーターは

* 起動時に静的に構築する
* 追加や削除は無い
* よって、構築する時間よりは検索時間が速いものが好ましい

という要件なので、Double Array による URL ルーターが本命ではないかと考えていますが、憶測より実測するべきなので、

* Ternary Search Tree
* Double Array
* Trie (前述の記事の実装)

の 3 つを実装、ベンチマークして速いものを採用しようかと考えています。
