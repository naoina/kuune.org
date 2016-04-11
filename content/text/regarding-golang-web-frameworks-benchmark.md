+++
date = "2015-02-11T14:18:11+09:00"
draft = false
title = "golang web frameworks benchmark 02/2015 について"
tags = ["go", "golang"]

+++

最近 [golang web frameworks benchmark 02/2015](https://quip.com/Ha0bAfeh1ZVY) という記事が出回っていて大変遺憾なので、件の記事がいかにゴミかをつらつらと書いていきます。

### ace と Gin は HttpRouter を使っている

HttpRouter が king of performance なのはまぁいいです。
ですが、2 番目に位置づけている ace と Gin は HttpRouter を使っていることについて言及がありません。

### Goji を 3 番目 にしている理由がベンチマークと関係ない

タイトルに golang web frameworks benchmark 02/2015 と付けているにも関わらず Goji を 3 番目にしている理由がベンチマークと関係ない「安定している」です。
しかもベンチマークを見てもらえば分かりますが、別に 3 番目に速いというわけでもないです。

### Denco に言及がない

手前味噌ですが、自分が作っている [Denco](https://github.com/naoina/denco) という URL ルーターについて、ベンチマークでも安定して上位にいるにも関わらず一切の言及がありません。
前述した ace と Gin が HttpRouter を使っているということを鑑みると、このベンチマークは実質 HttpRouter 系 vs Denco という構図になります。

### まとめ

調べもしないで恣意的にしか書けないならベンチマークを持ち出すな。
という文句を英語で書いて広めたいけどそんな英語力無いから日本語で書いた。
