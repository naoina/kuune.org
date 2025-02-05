+++
date = "2014-02-20T22:28:50+09:00"
draft = false
title = "UI ファーストという開発手法"
"tags" = ["programming"]

+++

ソフトウェアエンジニアは新しく何かを開発する際に、技術的に可能かどうか、どう実装すればいいか、みたいなのを先んじて考えがちな気がする。
そういうボトムアップ的な思考は技術を知っているが故に出る自然な思考なのだが、私の経験上そういう思考で作られたものは大体使いづらい、いわゆる gomi が出来上がる。

なぜか？それは UI を考える際に実現可能性や実装のしやすさを優先してしまうから。
ここでいう UI とは WEB サービスやネイティブアプリなどに限らず、ライブラリなどであれば API を指す。

私は数年前から UI → 実装という開発順序で開発をしていて、それは以下のような感じ。

1. まず実現可能性を窓から投げ捨てる
1. 素晴らしいと思う UI を考える
1. その素晴らしい UI を実現するための実装方法を考える

こういう感じで進めると、ほとんどの場合、素晴らしい UI を実現するための方法がすごく煩雑になったり難しくなるのだけど、ここで UI を実装寄りにしてしまうと元の木阿弥で gomi が出来上がるので歯を食いしばって泣きながら実装する。
最初に実現可能性を捨てて UI を考えると実装できない UI になると思うかも知れないが、まぁ大体なんとかなるし、なんとかするべきである。

ただ、素晴らしいと思っていた UI が実は gomi だったということはよくあるし、そういうのはゴミ箱にダンクシュートするしかない。
