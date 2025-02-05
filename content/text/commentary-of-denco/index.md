+++
date = "2014-06-17T17:52:45+09:00"
draft = false
title = "Denco 技術解説"
"tags" = ["go", "golang", "denco"]

+++

今回は Golang 用の URL ルーターである [Denco](https://github.com/naoina/denco) の技術解説をしていきます。
その前にひとつ、お知らせがあります。Denco はこのたび URL ルーターから URL ルーター兼 HTTP request multiplexer となりました。つまり、[http.ServeMux](http://golang.org/pkg/net/http/#ServeMux) の代わりとして使えるようになりました。
詳しくは [README](https://github.com/naoina/denco/blob/master/README.md) を参照してください。

## 基本戦略

まず始めに、Denco のルーティングは静的パス（`/user/alice` みたいなの）とパラメーター付きパス（`/user/:name` みたいなの）で使用するアルゴリズムを変えています。
静的パスの場合は Go の map を使い、パラメーター付きパスの場合はパラメーターを扱えるように拡張したダブル配列を使います。これは、静的パスの場合、ダブル配列で処理するより Go の map を使ったほうが速いからです。
ですが、パラメーター付きパスは Go の map では扱えないので、拡張したダブル配列を使うことになります。今回はこのダブル配列の拡張についての解説です。

ダブル配列というのは [Trie](http://ja.wikipedia.org/wiki/%E3%83%88%E3%83%A9%E3%82%A4%E6%9C%A8) という主に文字列検索に使われるデータ構造の実装方法のひとつで、Trie の実装の中では最速の部類に入るものです。
詳しい概要については http://nanika.osonae.com/DArray/dary.html や http://d.hatena.ne.jp/takeda25/20120219/1329634865 を参照してください。
以下からはダブル配列を理解している前提での解説になります。

## 拡張ダブル配列

さて、ダブル配列は速い Trie の実装ではありますが、静的な文字列に対するものなのでパラメーター付きパスのような特定の文字に意味を持たせるということがそのままではできません。
そこで、Denco では構築時およびルックアップ時にメタ文字である `:` と `*` を特別扱いするようにダブル配列を拡張しています。

### シングルパラメーター

まず Denco の仕様として `/user/:name/:id` などの `:name` や `:id` の部分は任意の文字列にマッチします。マッチする長さは次の `/` が現れるまでか、終端までです。
例えば `/user/:name/:id` に対して `/user/alice/1` でマッチを試みた場合、`:name` には `alice` が、`:id` には `1` がマッチします。

#### 構築

まず構築に使用する文字列は **レコード** と呼びます。レコードには文字列の他にパラメーター名を保持するスライスをフィールドとして持たせます。
ダブル配列の構築では先頭から 1 文字ずつ見て構築していくのですが、Denco ではこのとき、`:` という文字が現れた場合、次の `/` の前、または終端まで読み込みます。
`/user/:name/:id` であれば、最初の `:` が現れたとき `:` から次の `/` の前まで読み込み、`:name` という文字列を得ます。

`:` はメタ文字なので、そのあとの `name` が実際のパラメーターの名前になります。こうして得たパラメーターの名前をレコードのパラメーター名を保持するスライスに追加します。
また、レコード自体は参照時には使用しなくなるので、参照時に使用する BASE/CHECK の配列の要素にシングルパラメーターであるというフラグを立てておきます。
これで構築におけるシングルパラメーターの処理は終了なので、通常のダブル配列の構築に戻ります。
`/user/:name/:id` というレコードを構築すると、上記処理によって `/user/:/:` として構築され、`:` の位置に対応する BASE/CHECK 配列の要素にはシングルパラメーターであるというフラグが立っていることになります。

レコードの終端まで処理が終わればレコードに対するデータを実際に保持するノードを生成し、そのノードにパラメーター名を保持するスライスをレコードからコピーします。
このノードは専用の配列に格納され、ルックアップに成功した場合に対応するノードが取り出されますが、今回は割愛します。

#### ルックアップ

まず、`/user/:name/:id` というレコードは `/user/:/:` として構築されています。これに対して `/user/alice/1` という文字列のルックアップを試みると以下のようになります。

```text
/user/:/:

/
/u
/us
/use
/user
/user/
/user/a ← a と : は違うので失敗！
```

始めは BASE/CHECK 配列を使って普通にダブル配列のルックアップをしていきます。すると上記のように `:` の場所で失敗します。
通常のダブル配列ならば失敗した時点でその文字列は無いということになるのですが、Denco では下記のように処理を続けます。

1. 失敗した時点での BASE/CHECK 配列の要素のシングルパラメーターかどうかのフラグを調べる
2. シングルパラメーターでない場合、後述するワイルドカードパラメーターのチェックに移る
3. ワイルドカードパラメーターのチェックも失敗した場合、ルックアップは失敗する
4. シングルパラメーターの場合、現在の位置から次の `/` の前、または終端まで読み込みパラメーターとする
5. 読み込んだあとからダブル配列のルックアップを再開
6. 上記を繰り返し、最後まで読んだら終了

```text
/user/:/:

/
/u
/us
/use
/user
/user/
/user/a ←失敗！

      v ←現在位置
/user/a → 現在の位置がシングルパラメーターであるかをチェック

  ↓ /user/: の部分にあたるので現在位置はシングルパラメーター

/user/alice → "alice" を読み込みパラメーターとする

           v ←再開位置
/user/alice/
/user/alice/1 ←失敗！

            v ←現在位置
/user/alice/1 → 現在の位置がシングルパラメーターであるかをチェック

    ↓ /user/:/: の部分にあたるので現在位置はシングルパラメーター

/user/alice/1 → "1" を読み込みパラメーターとする

最後まで読んだので終了 → /user/alice/1 はマッチ、"name" パラメーターの値は "alice"、"id" パラメーターの値は "1"
```

### ワイルドカードパラメーター

#### 構築

ほぼシングルパラメーターと同様ですが `*` という文字が現れた場合、ワイルドカードパラメーターとして扱います。
シングルパラメーターのときは次の `/` の前、または終端まで読み込みますが、Denco のワイルドカードパラメーターの場合は常に終端まで読み込みます。
ですので、`/static/*filepath` というレコードの場合 `filepath` がパラメーターの名前になりますが、`/static/*filepath/robots.txt` とあった場合は `filepath/robots.txt` が名前になってしまいますので注意してください。

また、参照時に使用する BASE/CHECK の配列の要素にはワイルドカードパラメーターであるというフラグを立てます。
`/static/*filepath` というレコードを構築すると `/static/*` として構築されます。

#### ルックアップ

シングルパラメーターでのルックアップとほぼ同様ですが、失敗した際にワイルドカードパラメーターの場合は常に終端まで読み込まれ、それがパラメーターの値になります。
`/static/image/logo.png` という文字列をルックアップすると以下のようになります。

```text
/static/*filepath

/
/s
/st
/sta
/stat
/stati
/static
/static/
/static/i ←失敗！

        v ←現在位置
/static/i → 現在の位置がワイルドカードパラメーターであるかをチェック

    ↓ /static/* の部分にあたるので現在位置はワイルドカードパラメーター

/static/image/logo.png → "image/logo.png" を読み込みパラメーターとする

最後まで読んだので終了 → /static/image/logo.png はマッチ、"filepath" パラメーターの値は "image/logo.png"
```

シングルパラメーターとワイルドカードパラメーターの優先順位は シングルパラメーター > ワイルドカードパラメーター です。
例えば `/user/:name` と `/user/*any` というレコードがあった場合、`/user/alice` は `/user/:name` にマッチします。

## まとめ

Denco ではどのようにしてダブル配列を拡張してパラメーターを扱えるようにしているかをざっくりと解説しました。
実際には今回解説した処理に加えてバックトラックによるパラメーターマッチをしています。バックトラックを行うことによって `/user/:name/:id` と `/user/alice/:id` のようなレコードを一緒に扱うことができるようになっています。
興味があればソースを読んでみてください。
