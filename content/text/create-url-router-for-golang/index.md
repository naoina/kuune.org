+++
date = "2014-01-08T23:36:36+09:00"
draft = false
title = "Golang 用 URL ルーター作った"
"tags" = ["go", "golang", "trie"]

+++

https://github.com/naoina/kocha-urlrouter

これ http://naoina.plog.la/2013/12/16/230502728087 の最後に書いた URL ルーターの実装をした。
Kocha で使う用にひと通り実装したものを別ライブラリとして切り出したものになる。
使い方は README.md みれば多分分かると思う。
Golang の標準ライブラリの `database/sql` と同じようなコンパイルタイムプラグインの方式を取っているので、色んな URL ルーターの実装ができ、用途によって切り替えるとかできる。
現在の実装は ダブル配列 と 正規表現 の 2 つがある。ダブル配列は構築は遅いが lookup が速い。ベンチマークを取ると分かるが、私の環境だと正規表現実装と比べて、ルート数が 100 の場合は約 17 倍、ルート数 700 の場合だと約 110 倍速い。

## Golang 界隈の WEB フレームワークにおける URL ルーターの状況

Golang で作られている WEB フレームワークには [Revel](https://github.com/robfig/revel)、[beego](https://github.com/astaxie/beego/)、[Martini](https://github.com/codegangsta/martini)、URL ルーターは [gorilla/mux](https://github.com/gorilla/mux) などがありますが、これらの URL ルーターの実装は<del>全て、ループを回して正規表現などでマッチングする方法を取っています</del>(勘違いしてましたが、Revel は Trie により実装でした)。つまりルートの数が増えれば増えるほど遅くなります。
これらのフレームワークが何故この方法を取っているのかは知りませんが、実装が簡単なのと、URL ルーターがまだそこまでパフォーマンスに与える影響がない（他の部分の方が重い）からですかね。。。

## 閑話休題

これ作るために色々調べてて、割と Trie というか、そのへんに興味出てきたので、今後はダブル配列の末尾文字列圧縮や三分探索木、 LOUDS、ウェーブレット行列での実装とかも入れたいですね。

### 追記1

三分探索木の実装を入れたらダブル配列より速くなったしにたい。

### 追記2

ダブル配列速くしたので、速度はダブル配列の方がちょっとだけ速くなった。メモリ効率はダブル配列の方が約 2 倍から 3 倍程度良いが、構築は三分探索木の方が約 2 倍速い。
というか、URL ルーターとして使う文には何万件とか入れないだろうし、メモリプロファイルとった限りでは三分探索木でも 700 件で 3MB ぐらいしか使ってないし、ダブル配列を使う意義とは。。。
