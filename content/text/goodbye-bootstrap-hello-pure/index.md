+++
date = "2013-06-20T20:30:34+09:00"
draft = false
title = "Goodbye Bootstrap, Hello Pure"
"tags" = ["bootstrap", "pure", "css"]

+++

今までplogのデザインは適当でもある程度見れるという理由で [Twitter Bootstrap](http://twitter.github.io/bootstrap/) を使ってましたが、今流行りのフラットデザインにするべく [Pure](http://purecss.io/) を使うように変更しました。
といっても、Pure は Bootstrap みたいにオールインワンではなくベースの部分を提供してくれるだけなので、割と自前で CSS を書きました。
あとどうでもいいですが実際に書いたのは SCSS です。

## Bootstrapはオワコン

近年、新しく出てくる何かしらのWEBサービスは Bootstrap を使ってることが多く、大体ひと目で「あっ！このサイトブートストラップだ！」って分かるわけです。
使う方は非常に楽でいいのですが、さすがに Bootstrap のサイトが多いので食傷気味になるわけです。ああここもか・・・みたいな。[^1]
それに加えて、フラットデザインの台頭で Bootstrap はオワコン化すると思うのでさっさとやったほうがいいと思ってゴッソリ置き換えた次第です。
まぁ Bootstrap はなんだかんだで便利だし、http://bootswatch.com/cosmo/ 使えばフラットデザインできるので実際オワコン化するかは分からないですが。

## Pureを選んだ理由

Pure を選んだ理由は、単に Pure のサイトがフラットデザインっぽかったのでこれ使えばフラットデザインにできるんだろうなって思ったからです。
実際にはそんなことはなかったですが、レスポンシブ対応グリッド、フォームとメニューが良しなになってくれるだけで随分楽だと思います。
あとは自分の中で必要最小限のものでよかったというのもあります。個人的にオールインワンのものは応用を利かせにくくて好きじゃないので。

## まとめ

Bootstrap で満足してるなら Pure 使わなくてもいいし、CSS をある程度分かってないと Pure を使うのは難しい。

## 蛇足

* ついでにスマートフォン対応もしました。
* ついでに Web Clip[^2] にも対応しました。

[^1]: フラットデザインもすでに流行りまくってて食傷気味という話もありますが
[^2]: iPhone とかでホーム画面にWEBページへのショートカット置けるアレ
