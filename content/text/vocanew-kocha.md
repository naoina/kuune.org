+++
date = "2015-04-01T23:22:40+09:00"
publishdate = "2015-04-01T23:22:40+09:00"
draft = false
title = "ぼかにゅーを Kocha で再実装しました"
tags = ["vocanew"]

+++

先日 Kocha v0.7.0 をリリースしたんですが、今回そのテストとして [ぼかにゅー](http://vocanew.kuune.org) を Kocha で実装し直しました。
ぼかにゅーの実装ははこれまで Symphony（PHP）→ Revel（Go）と来て今回で 3 度目の実装となります。
今のところ大きな問題は起きておらずいい感じです。

また今回 Kocha で実装し直したのもあって、ぼかにゅーのサーバーサイド実装を GitHub にて公開することにしました。

https://github.com/naoina/vocanew

ちなみに公開したものはあくまで Kocha のリファレンス実装という位置づけなのでクローラーは含まれていません。
