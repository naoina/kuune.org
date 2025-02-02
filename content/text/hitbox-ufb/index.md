+++
title = "Hit Boxの基盤をUFBに換装する"
date = 2021-06-10T20:28:35+09:00
draft = false
"tags" = ["hitbox", "ufb", "game", "misc"]
+++

Hit Boxの基盤をBrookのUniversal Fighting Board(以下UFB)に載せ換えたので書いておきます。
UFBのJ9を別用途に使いたかったので今回の手順ではコードを切ったり繋げたりしました。なので同じことをすると元のHit Boxの基盤に戻せません。もし行う場合は自己責任でお願いします。

J9を使う場合は下記を買って繋ぐだけでできると思いますが、ファストン端子は曲げないと多分ケースに収まらないです。（やったことはないのでこちらも自己責任でお願いします

{{< card url="https://amzn.to/4dJJZIe" >}}

{{< card url="https://amzn.to/3Tdd7iJ" >}}

## 必要なもの

- [Universal Fighting Board](https://amzn.to/4g3u4WL)
  - ピンヘッダとコネクタがハンダ付けされているバージョンを選びます
    {{< card url="https://amzn.to/4g3u4WL" >}}
- [QIコネクタ](https://amzn.to/3Z4oPA0)
  - デュポンコネクタとも言われるようです。USBの再結線用に必要です。Hit Boxに元々ついているコネクタはUFBには使い回せません
    {{< card url="https://amzn.to/3Z4oPA0" >}}
- [PHコネクタ](https://amzn.to/4e84luD)
  - TOUCH PAD KEY/L3/R3ボタンを繋げるのに必要です
    {{< card url="https://amzn.to/4e84luD" >}}
- ニッパー
  - コードを切るのに使います。ハサミでもいいかもしれません
- 圧着ペンチ
  - 自分は [ホーザンP-706](https://amzn.to/4fZYlG5) を買いました
    {{< card url="https://amzn.to/4fZYlG5" >}}
- ワイヤーストリッパー
  - ニッパーやカッターでも被覆を剥けますが、あったほうが圧倒的に効率がいいです
  - 自分は [ベッセル3500E-2](https://amzn.to/3MpSjB1) を買いました
    {{< card url="https://amzn.to/3MpSjB1" >}}
- 絶縁テープ
  - ビニールテープでもいいですが、剥がしてもベタベタしない自己癒着テープが便利です
    {{< card url="https://amzn.to/3XpJQUv" >}}

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
