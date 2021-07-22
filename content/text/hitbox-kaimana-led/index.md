+++
title = "Hit Boxのボタンを光らせる"
date = 2021-07-22T22:42:55+09:00
draft = false
"text/tags" = ["hitbox", "game", "misc"]
+++

今回はHit Boxのボタンを光らせます。諸々の都合上、[Hit Boxの基盤をUFBに換装]({{< relref "text/hitbox-ufb/index.md" >}}) していることが前提となります。

## 必要なもの

- [Kaimana Mini LED Driver & PCB 8 Button Kit](https://paradisearcadeshop.com/products/paradise-kaimana-mini-led-driver-pcb-8-button-kit)
  - 光らせるためのキットです。作るための学習コストや手間を省くために既製品を使います
  - 海外発送かつ購入時は新型コロナウイルスの影響もあって届くのに1ヶ月以上かかりました
  {{< card url="https://paradisearcadeshop.com/products/paradise-kaimana-mini-led-driver-pcb-8-button-kit" >}}
- [Kaimana J2 RGB LED](https://paradisearcadeshop.com/products/paradise-kaimana-j2-rgb-led) x 4
  - Hit Boxは移動、打撃用ボタンが合計12個あるので、セットで足りない分を追加で購入します
  - StartやHomeボタンも光らせたい場合はさらに追加で必要です
  {{< card url="https://paradisearcadeshop.com/products/paradise-kaimana-j2-rgb-led" >}}
- [Kaimana J2 3" Wire Harness](https://paradisearcadeshop.com/products/paradise-kaimana-j2-3-wire-harness) x 4
  - LEDを足した分ハーネスも追加で必要です
  - 売ってるものは3インチが1番短いですが、もっと短くてもよくて、その場合PHコネクタの3Pと4Pで作成できます
  {{< card url="https://paradisearcadeshop.com/products/paradise-kaimana-j2-3-wire-harness" >}}
- 三和 or セイミツのクリアボタン
  - Kaimana J2 RGB LEDは三和、セイミツ、Jyueeangの30mmか24mmのボタンに対応しているので、それらのボタンが必要です
  - 後述しますが、LEDの色を変えて光らせたい場合は透明なクリアボタン(三和ならクリア白)を選ぶほうがよいです
  {{< card url="https://attasa.shop/shopdetail/000000000079/" >}}
  {{< card url="https://attasa.shop/shopdetail/000000000076/" >}}
- Micro USBケーブル
  - Kaimana Mini LED DriverとPCを繋いでプログラムを書き込んだりするのに使います

## 組み立て

{{< figure src="parts.jpg" title="すべてのパーツ。ハーネスは1本少なく注文してしまったので後で作りました" >}}

まずはJ2 RGB LEDをハーネスで繋いでいきます。ハーネスのコネクタは片方が3P、もう片方が4Pで、J2 RGB LED側もそうなっているので間違ったほうに繋ぐことはないと思います。

{{< figure src="j2_rgb_led_1.jpg" title="J2 RGB LEDハーネス側" >}}

{{< figure src="j2_rgb_led_1.jpg" title="J2 RGB LEDボタン側" >}}

{{< figure src="harness_1.jpg" title="J2 RGB LEDをハーネスで数珠つなぎにする" >}}

すべて繋げたらKaimana Mini LED Driver本体にもハーネスで繋ぎます。

{{< figure src="kaimana_1.jpg" title="Kaimana Mini LED Driver本体上側" >}}

{{< figure src="kaimana_2.jpg" title="Kaimana Mini LED Driver本体下側" >}}

{{< figure src="harness_2.jpg" title="ひとつだけコネクタが大きいハーネスは本体用です" >}}

{{< figure src="harness_3.jpg" title="本体とJ2 RGB LEDを繋いだところ" >}}

ここまでできたら1度本体とPCをMicro USBで繋いでみます。PCと繋ぐとUSB給電でLEDが光り始めます。

{{< figure src="lightup.jpg" title="こいつ、光るぞ！？" >}}

光ることを確認したら、Hit Box側のUFBに繋げましょう。UFBのJ9にKaimana本体を挿します。

J9の位置は https://www.brookaccessory.com/detail/06960737/#cont10 で確認できます。

{{< figure src="ufb_kaimana.jpg" title="ピンが10本2列で出ているところがJ9なのでそこに挿す" >}}

もしJ9をBrookのハーネスの接続に使ってたりする場合、ボタンの結線をJ3を使うようにやり直すなりする必要があります。
ボタンの再結線については[前回の記事]({{< relref "text/hitbox-ufb/index.md#ボタンコードの再結線" >}})を参考にしてください。

{{< figure src="hitbox_kaimana.jpg" title="UFBとKaimanaを繋げた全体像" >}}

## Arduino用開発環境の構築

まずはArduino用の開発環境を整えます。
自分はarduino-cliを使いましたのでこれを前提に話を進めます。と言っても大体下記のGetting Startedの通りです。

https://arduino.github.io/arduino-cli/latest/getting-started/

Arduino IDE使う場合は適当にググったらいっぱい記事が出てくると思うのでそちらを参考にしてください。

まずは設定を作成して、

```bash
% arduino-cli config init
```

利用可能なプラットフォームなどの情報を更新します。

```bash
% arduino-cli core update-index
```

KaimanaとPCをMicro USBで繋げて下記コマンドを叩くと認識されていることがわかります。

```bash
% arduino-cli board list
Port         Type              Board Name       FQBN                 Core
/dev/ttyACM0 Serial Port (USB) Arduino Leonardo arduino:avr:leonardo arduino:avr
/dev/ttyS0   Serial Port       Unknown
/dev/ttyS4   Serial Port       Unknown
```

自分の環境ではリストの1番上がKaimanaですね。表示されるPort(ここでは`/dev/ttyACM0`)とFQBN(ここでは`arduino:avr:leonardo`)はプログラムのコンパイルとKaiamaに書き込むときに必要になります。

Coreに `arduino:avr` が必要なのでインストールします。

```bash
% arduino-cli core install arduino:avr
```

```bash
% arduino-cli core list
ID          Installed Latest Name
arduino:avr 1.8.3     1.8.3  Arduino AVR Boards
```

`arduino-cli` を使う環境構築はこれで終わりです。次は実際にLEDを光らせるためのプログラムをあれやこれやします。

## LEDを光らせるためのプログラム

元のプログラムからHit Boxに対応して色々と自分好みに書き直したものをGitHubに置いたのでこれを使います。

https://github.com/naoina/kaimana

ボタンとLEDの対応は、数珠つなぎになっているJ2 RGB LEDの順番によって決められます。設定は下記の箇所です。

https://github.com/naoina/kaimana/blob/752c8333674b53d7cd10ce4149c98f6cd30a483b/hitbox/kaimana_custom.h#L36-L70

```c
// Kaimana J2 RGB LED has 2 LEDs.
#define  LED_P1_1      16
#define  LED_P2_1      14
#define  LED_P3_1      12
#define  LED_P4_1      10
#define  LED_K1_1      2
#define  LED_K2_1      4
#define  LED_K3_1      6
#define  LED_K4_1      8
#define  LED_LEFT_1    22
#define  LED_DOWN_1    20
#define  LED_RIGHT_1   18
#define  LED_UP_1      0
#define  LED_HOME_1    24
#define  LED_GUIDE_1   26
#define  LED_SELECT_1  28
#define  LED_BACK_1    30
#define  LED_START_1   32
#define  LED_P1_2      (LED_P1_1 + 1)
#define  LED_P2_2      (LED_P2_1 + 1)
#define  LED_P3_2      (LED_P3_1 + 1)
#define  LED_P4_2      (LED_P4_1 + 1)
#define  LED_K1_2      (LED_K1_1 + 1)
#define  LED_K2_2      (LED_K2_1 + 1)
#define  LED_K3_2      (LED_K3_1 + 1)
#define  LED_K4_2      (LED_K4_1 + 1)
#define  LED_LEFT_2    (LED_LEFT_1 + 1)
#define  LED_DOWN_2    (LED_DOWN_1 + 1)
#define  LED_RIGHT_2   (LED_RIGHT_1 + 1)
#define  LED_UP_2      (LED_UP_1 + 1)
#define  LED_HOME_2    (LED_HOME_1 + 1)
#define  LED_GUIDE_2   (LED_GUIDE_1 + 1)
#define  LED_SELECT_2  (LED_SELECT_1 + 1)
#define  LED_BACK_2    (LED_BACK_1 + 1)
#define  LED_START_2   (LED_START_1 + 1)
```

また、1つのJ2 RGB LEDには2つのLEDがついていて、それぞれに番号が振られるので、ボタンごとに2つ番号があることになります。

{{< figure src="led_order.jpg" title="" >}}

自分は上ボタンから順番に上図のようにLEDを数珠つなぎにしているので、`LED_UP_1`が`0`、`LED_UP_2`が`1`、`LED_K1_1`が`2`、`LED_K1_2`が`3`…というふうにしています。

もし使うJ2 RGB LEDが12個より多いか少ない場合、下記`LED_COUNT`をJ2 RGB LEDの個数x2に設定する必要があります。

https://github.com/naoina/kaimana/blob/4c8ea5ef06ce118d1b747247eaed29ebd909cc3f/hitbox/kaimana_custom.h#L75

```c
#define  LED_COUNT   24
```

諸々設定できたらコンパイルします。

```bash
arduino-cli compile --fqbn arduino:avr:leonardo hitbox
```

`--fqbn` オプションには `arduino-cli board list` で表示されるFQBNを指定します。

```bash
% arduino-cli board list
Port         Type              Board Name       FQBN                 Core
/dev/ttyACM0 Serial Port (USB) Arduino Leonardo arduino:avr:leonardo arduino:avr
/dev/ttyS0   Serial Port       Unknown
/dev/ttyS4   Serial Port       Unknown
```

コンパイル時にエラーが出なければ、KaimanaとPCをMicro USBで繋げてから下記コマンドで書き込みます。

```bash
arduino-cli upload -p /dev/ttyACM0 --fqbn arduino:avr:leonardo hitbox
```

`-p` オプションに指定する `/dev/ttyACM0` も `arduino-cli board list` で表示されるPortを指定します。

正常に終了したら動作確認をしましょう。 https://github.com/naoina/kaimana を使っている場合、スタートボタンを約3秒長押しすると全部のボタンが光ってLEDがONになります。

動作確認できたらJ2 RGB LEDをボタンに取り付けます。取り付けはファストン端子を外してJ2 RGB LEDを置き、ファストン端子を挿し直します。
J2 RGB LEDの取り付けは向きがあります。無理なくボタンにハマる向きが正しいです。
取り付けるといってもJ2 RGB LEDが固定できるようになっていないので、ボタンに置いておく感じになります。

{{< figure src="led_button_30.jpg" title="30mmボタンに置いたところ。サイズピッタリ" >}}

{{< figure src="led_button_24.jpg" title="24mmボタンに置いたところ。はみ出る" >}}

{{< figure src="order.jpg" title="すべて取り付けた図" >}}

ここまでできたらフタを締めて再び動作確認しましょう。

## LEDの光る色を設定する

ボタンを押すとLEDが光る状態にします。もし光らない場合はスタートボタンを約3秒長押しして光る状態にしてください。
その状態でセレクトボタン(Hit Boxだと側面のボタンの右から2番目)を約3秒長押しすると、LEDの設定モードになり、すべてのLEDが光ったままになります。
次に色を設定したいボタンを押します。押した(選択した)ボタンによって操作するボタンが変わります。

#### 攻撃ボタン(`P`か`K`)を選択した場合

RGBの値のうち、左ボタンがR、下ボタンがG、右ボタンがBを、それぞれ15増やす動作になります。

#### 移動ボタン(上下左右)を選択した場合

RGBの値のうち、`P1` か `K1` ボタンがR、`P2` か `K2` ボタンがG、`P3` か `K3` ボタンがBを、それぞれ15増やす動作になります。

RGBの値はそれぞれ0から255となっていて、255を超えるとまた0から始まります。
スタートボタンを押すと色を決定し、設定するLEDを選択するモードに戻ります。

ちなみに、色の付いたクリアボタンの場合、何色に光らせてもほぼボタンの色にしかならないので白でいいと思います。三和のクリア白とかだとクリア部分が完全に透明で、LEDの色がちゃんと見えるため色を変えて楽しめます。

すべて設定し終わったら、LEDを選択するモード(すべてのLEDが光っている状態)でセレクトボタンを約3秒長押しすれば設定が保存されます。

## まとめ

{{< figure src="hitbox.jpg" title="光らないHit Box。良い" >}}

{{< figure src="hitbox_lightup.jpg" title="光るHit Box。とても良い" >}}

ここまでやるとHit Boxはガワだけしか残ってないんですが、それは言わない約束です。
