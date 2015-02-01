+++
date = "2014-01-20T09:31:19+09:00"
draft = false
title = "FeatureToggle ライブラリ書いた"

+++

https://github.com/naoina/gocchan

FeatureToggle とはなんぞや？という方は http://martinfowler.com/bliki/FeatureToggle.html とか見てください。日本語の情報はかなり少ないようです。

今回作ったのは Gocchan という golang 用 FeatureToggle ライブラリです。読みは「ごっちゃん」です。Go の channel とは一切関係ないです。
Ruby on Rails 用のそういったライブラリとして [Chanko](https://github.com/cookpad/chanko) というのがあるのですが、まぁ名前や機能はそこから来てます。

使い方は以下のような感じです。

```go
package main

import "github.com/naoina/gocchan"

type MyFeature struct {}

func (f *MyFeature) ActiveIf(context interface{}, options ...interface{}) bool {
    return true
}

func (f *MyFeature) ExecMyFeature(context interface{}) {
    // do something.
}

func init() {
    gocchan.AddFeature("name of feature", &MyFeature{})
}

func main() {
    gocchan.Invoke("context", "name of feature", "ExecMyFeature", func() {
        // default processes.
    })
}
```

この例でいうと、`ActiveIf` が `true` を返した場合に `ExecMyFeature` が実行され、`false` を返した場合は `Invoke` に渡した関数（デフォルト関数）が実行されます。
例えば `ActiveIf` の返す値を設定ファイルや DB から持ってくるようにしていれば、まさに FeatureToggle として機能します。
また、Chanko と同様に、`Invoke` の中（`ExecMyFeature` メソッドの中など) でエラーが発生した場合もデフォルト関数が呼ばれます。ですので、単なるフラグを使って if-else で分岐するよりも安全です。
`Invoke` の第 1 引数には任意のオブジェクトが渡せ、それが `ActiveIf` や Feature function (この例でいうと `ExecMyFeature`) に渡されますので、これを使って自由に機能を追加できます。

まぁこれだけのライブラリですが、FeatureToggle 用途として普通に使えるんじゃないかと思います。
