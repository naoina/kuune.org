+++
title = "Hit Boxの基盤をUFBに換装する"
date = 2021-06-10T20:28:35+09:00
draft = false
"text/tags" = ["hitbox", "ufb", "game", "misc"]
+++

Hit Boxの基盤をBrookのUniversal Fighting Board(以下UFB)に載せ換えたので書いておきます。
UFBのJ9を別用途に使いたかったので今回の手順ではコードを切ったり繋げたりしました。なので同じことをすると元のHit Boxの基盤に戻せません。もし行う場合は自己責任でお願いします。

J9を使う場合は下記を買って繋ぐだけでできると思いますが、ファストン端子は曲げないと多分ケースに収まらないです。（やったことはないのでこちらも自己責任でお願いします

<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoina09-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B083JX5H2B&linkId=6389be9ceb290a3caa754bc8ade018c4"></iframe>
<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoina09-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B083JW59Y3&linkId=233765a793c1168412acab67b769583e"></iframe>

## 必要なもの

- [Universal Fighting Board](https://www.amazon.co.jp/Brook-Universal-Fighting-%E3%82%A2%E3%82%B1%E3%82%B3%E3%83%B3%E5%9F%BA%E6%9D%BF-Switch%E5%AF%BE%E5%BF%9C/dp/B07RYYX6LK?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&dchild=1&keywords=ufb&qid=1622562000&sr=8-1&linkCode=ll1&tag=naoina09-22&linkId=ddccc0b88c8f4ee322f7b6467095e268&language=ja_JP&ref_=as_li_ss_tl)
  - ピンヘッダとコネクタがハンダ付けされているバージョンを選びます
- [QIコネクタ](https://www.amazon.co.jp/gp/product/B087C49W9M?ie=UTF8&psc=1&linkCode=ll1&tag=naoina09-22&linkId=ff7e90b064a62fed4f74b08abac0d3ae&language=ja_JP&ref_=as_li_ss_tl)
  - デュポンコネクタとも言われるようです。USBの再結線用に必要です。Hit Boxに元々ついているコネクタはUFBには使い回せません
- [PHコネクタ](https://www.amazon.co.jp/gp/product/B08JYNRTS1?ie=UTF8&psc=1&linkCode=ll1&tag=naoina09-22&linkId=27e89a37bd4b0ba8c6189c8842531a14&language=ja_JP&ref_=as_li_ss_tl)
  - TOUCH PAD KEY/L3/R3ボタンを繋げるのに必要です
- ニッパー
  - コードを切るのに使います。ハサミでもいいかもしれません
- 圧着ペンチ
  - 自分は [ホーザンP-706](https://www.amazon.co.jp/gp/product/B002TKG11G?ie=UTF8&psc=1&linkCode=ll1&tag=naoina09-22&linkId=a2804c84269e45882a0ce9ee0c0c231e&language=ja_JP&ref_=as_li_ss_tl) を買いました
- ワイヤーストリッパー
  - ニッパーやカッターでも被覆を剥けますが、あったほうが圧倒的に効率がいいです
  - 自分は [ベッセル3500E-2](https://www.amazon.co.jp/gp/product/B000CEAXM4?ie=UTF8&psc=1&linkCode=ll1&tag=naoina09-22&linkId=b3b318150e0f394c6cb4e2230485d795&language=ja_JP&ref_=as_li_ss_tl) を買いました
- 絶縁テープ
  - ビニールテープでもいいですが、剥がしてもベタベタしない自己癒着テープが便利です

<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoina09-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B08H1TCFB1&linkId=a081c68f5cdd277d207f0bb6140405d2"></iframe>
<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoina09-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B002TKG11G&linkId=03995cd221c417a064caa34f4953a240"></iframe>
<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoina09-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B000CEAXM4&linkId=d95e16448b7d6c60a6ef258a0f87a489"></iframe>
<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoina09-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B08JYNRTS1&linkId=86d2cd839c6807e62c056109f1d3f187"></iframe>
<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoina09-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B087C49W9M&linkId=65f3a516de9604ce3db35e4f72bf46cf"></iframe>
<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoina09-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B010MYOQ7Q&linkId=80383b4027aa7a51b77e6907e656b558"></iframe>

## コードの切断

各ボタンのコードをUFBに繋げるために配線をする必要がありますが、今回は既存のコードを再利用することにしたため、まずはコードの切断をします。

{{< figure src="inside.jpg" title="純正のままの中身" >}}

{{< figure src="buttons_code.jpg" title="ここのボタンのコードをニッパーで全部切断します" >}}

{{< figure src="cut.jpg" title="切断したコネクタ" >}}

Hit Boxの取り外し可能なUSBコードコネクタはそのまま使いたいのですが、最初から挿さっているコネクタはUFBのUSBヘッダーピンと規格が違っていて、そのままではUFBに挿せないのでこちらも再結線するために切断します。

{{< figure src="hitbox_usb_connector.jpg" title="取り外し可能なUSBコードコネクタ" >}}

{{< figure src="hitbox_usb.jpg" title="このコネクタに繋がっているコードをニッパーで切ります" >}}

## ボタンコードの再結線

コードが切断できたらUFBに繋ぐために色々やります。

{{< figure src="awg22.jpg" title="ボタンのコードはAWG22で被覆を剥きます" >}}

ボタンコードの被覆を剥いたらJ3に挿してネジを締めて結線します。

{{< figure src="ufb_j3.jpg" title="この青いやつがJ3" >}}

差し込む導線の長さが短いと被覆に当たってうまく結線されないので、短すぎず長すぎずで被覆を剥かないといけません。
一旦差し込んでみて、剥く長さを計るとよいです。

どこに何のボタンのコードを繋ぐかはBrookのページを見てください。

https://www.brookaccessory.com/detail/06960737/#cont10

また、純正Hit Boxでは各ボタンのGNDが1本1本基盤に繋がっていますが、UFBのGNDの数は限られているのでGNDをまとめる処理が必要です。

{{< figure src="gnd.jpg" title="複数のGNDのコードを1本にまとめる" >}}

UFBに繋ぐGNDのコードは途中の被覆を剥いて導線を出し、先端の被覆を剥いた残りの各ボタンのGNDのコードを繋げて絶縁テープで巻きました。
本当はファストン端子を数珠つなぎにしたかったのですが、旗型のファストン端子がすぐに手に入りそうになかったので諦めました。

### TOUCH PAD KEY/L3/R3

TOUCH PAD KEY/L3/R3はJ3ではなくJ4に繋ぐ必要があるので、別でコネクタを作って挿します。

{{< figure src="ph_terminal.jpg" title="被覆を剥いたコードに端子をかしめます" >}}

ホーザンP-706でかしめる場合は1.7Lを使います。1.7Hだとかしめる高さが合わないのでうまくかしめられません。

{{< figure src="ph_terminal_size.jpg" title="端子は空いている方を上にします" >}}

端子の手前側は被覆に巻くやつなので、奥側を使ってかしめます。被覆用のはΦ1.8で軽く握って巻きます。

{{< figure src="ph_connector.jpg" title="PHコネクタにカチッと音がするまで差し込む" >}}

{{< figure src="j4.jpg" title="UFBのJ4に差し込む" >}}

## USBの再結線

ボタンのときと同じ感じで、被覆を剥いてQIコネクタ用端子をかしめてコネクタを作ります。

{{< figure src="awg26.jpg" title="USBのコードはAWG26で被覆を剥きます" >}}

{{< figure src="qi_terminals.jpg" title="端子は繋がってたりする" >}}

{{< figure src="qi_terminal.jpg" title="ニッパーで必要な分だけ切って使います" >}}

{{< figure src="qi_terminal_set.jpg" title="ボタンのコードと同じく1.7Lでかしめます" >}}

かしめた端子をPHコネクタのときと同じ要領でQIコネクタに挿します。

コードの色とUSB端子の対応は

- 赤: VDD
- 黄: D-
- 青: D+
- 黒: GND

です。

{{< figure src="qi_connector.jpg" title="QIコネクタ" >}}

黒の1番太いコードは元の基盤のコードと繋げてシャーシグラウンドを取ったほうが動作の安定性が上がるらしいのでそのようにします。
USBコード側はAWG20で、元の基盤のシャーシグラウンドを取るコードのほうはAWG18で剥いて結線してシャーシグラウンドを取ります。

{{< figure src="usb.jpg" title="J6-1のUSBピンにQIコネクタを挿します。シャーシグラウンドも取る" >}}

## UFBの通電確認LEDを光らないようにする

D1は青いチップLEDで、UFBに通電している場合にめっちゃ光ります。自分のHit Boxはクリアボタンにしているため邪魔だったのでニッパーで割りました。

{{< figure src="led.jpg" title="" >}}

## まとめ

Hit Boxの基盤をUFBに換装するのは手間はかかりますが、電子工作とか全くわからない自分でも意外に簡単にできました。

{{< figure src="hitbox.jpg" title="換装済みHit Box。良い" >}}

冒頭でも書いたとおり、単純にUFBに乾燥するだけならBrookから出ているハーネスセットを買ってつけるだけでできます。ですが、自分はJ9をボタンを光らせるためのハーネスに使いたかったので今回のような手順を取りました。
というわけで、次回はボタンを光らせる回です。
