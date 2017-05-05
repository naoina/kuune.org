+++
date = "2014-07-01T11:14:16+09:00"
draft = false
title = "Gin Web Framework について"
tags = ["go", "golang", "gin"]

+++

golang の新しい WEB アプリケーションフレームワークである [Gin Web Framework](http://gin-gonic.github.io/gin/) が出たらしいです。
この Gin、スゴイことにあの [Martini](https://github.com/go-martini/martini) より 40 倍速いとの触れ込みです。
ですが、この部分ちょっと違います。

まず、Martini と比べて **何が** 40 倍速いのか、というところですが

![20140701105236.png](/image/dd59ea0d-11d3-5dca-915f-ddb148cb4abc.png)

これ、HTTP ルーターの速度を測ってるんですね。速いですね。ちなみに *Check out the benchmark suite* ってところからベンチマークリポジトリに飛べます。

で、ここからが本題です。
Gin の HTTP ルーターは実は自前ではなく [HttpRouter](https://github.com/julienschmidt/httprouter) という他の方が作った爆速の HTTP ルーターを使っています。
つまり、Martini より 40 倍速いのは Gin 本体ではなく HttpRouter ということです。これはちゃんと [ここ](http://gin-gonic.github.io/gin/#features) の *Low Overhead Powerful API* にも明記されています。
ソースコードをざっと読んだ限りだと HttpRouter をチューニングして使っているということもなさそうなので、Gin 自体が Martini よりも 40 倍速いというのとはちょっと違うと思います。
多分 Martini よりも速い部分はあるのでしょうが、40 times faster の大部分は HttpRouter が持っていると思います。
github の starts 的にはマーケティングに成功してるっぽいですが、他人のプロダクトに乗っかってそれを広告に使うというのは私個人としては正直気持ち悪いです。

余談ですが、HttpRouter は https://github.com/julienschmidt/httprouter/issues/12 みたいなのがあるので、実用できるのか微妙な気がしています。
ちなみに私も [Denco](https://github.com/naoina/denco) という HTTP ルーターを作ってまして、興味があれば [前の記事](http://naoina.plog.la/2014/06/12/183508686252) をご覧ください。 
