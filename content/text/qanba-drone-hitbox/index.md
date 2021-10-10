+++
title = "Qanba Droneをレバーレス化する"
date = 2021-10-10T14:27:43+09:00
draft = false
"text/tags" = ["game", "qanba", "drone", "hitbox", "misc"]
+++

今まで[純正Hit Boxの基板をUFBに換装した]({{< relref "text/hitbox-ufb/index.md" >}})ものを使っていて、少し気になる点がありました。

## 純正Hit Boxの気になる点

- L3/R3ボタンがない
- 横に長い
- **奥行きが短いので筐体の角が手のひらに当たって座りが悪い**

#### L3/R3ボタンがない

L3/R3ボタンが標準で付いていません。付けるには本体に穴を開けてはんだ付けする必要があります。[^1]
L3/R3ボタンが無いと何が不便かというと、ストVではトレモでのリスタートや状態の保存がメニューを開かないとできないというところでしょう。[^2]

#### 横に長い

レバーのアケコンと違ってレバーレスのアケコンは方向入力がボタンなので、レバー操作により本体が上下左右に動くことはほぼなく、横幅を長くすることによる安定化が必要ありません。
加えて、自分は机に置いてプレイしているので横幅が短くても安定します。
そうなると横に長いのは単にスペースを取るだけなので、本体の横幅はできる限り短くなっていてほしいです。

#### 奥行きが短いので本体の角が手のひらに当たって座りが悪い

個人的に1番気になったのがこれで、本体の奥行きが短いため、ボタンに自然に手を置くと手のひらが本体の角にかかってしまって違和感がありました。痛くはないんですが、ここが斜めになっていればもっとストレスが無くなると感じていました。

{{< figure src="hitbox.jpg" title="この丸で囲った部分の角に手のひらが乗ってしまう" >}}

以上のような気になる点をすべて解消しているアケコンがありまして、それがQanba Droneです。

<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoina09-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B078SST6QC&linkId=e606778b5d6e5f9531ea2089db51425b"></iframe>

{{< figure src="qanba_drone.jpg" title="L3/R3ボタンある、コンパクト、手前側が斜めで手が置きやすいという最高の筐体" >}}

元々レバーのアケコンも欲しいなと思って買っておいたQanba Droneなのですが、結局全然使わず置物となっていたものを再利用してレバーレス化することにしました。

今回の記事ではQanba Droneのケースに穴を開けたり切ったり削ったりするので一度行うと元に戻せません。もし行う場合は自己責任でお願いします。

## 必要なもの

- Focus Attack SOCDクリーナー
  - Qanba Droneの基板はそのままだと上下同時押しは上優先、左右同時押しは左優先らしいので、左右同時押しをニュートラルにするために使います
  - 国内だと[千石電商](https://www.sengoku.co.jp/mod/sgk_cart/detail.php?code=EEHD-5UGM)、[叢雲商店](https://booth.pm/ja/items/3132340)で扱っています
  - 本家の[Focus Attack](https://focusattack.com/fa-so-cd-cleaner-for-all-button-control/)から個人輸入という手もあります
- プラス/マイナスドライバー
  - Qanba Droneのケースを開けるのに使ったりします
  - Qanba Droneのネジ穴は少し深めなので、プラスドライバーは長めのものが必要です
- 電動ドライバドリル
  - ボタンの穴を開けるのに使います。いちど手動で開けたのですが、めちゃくちゃ辛かったので絶対に用意したほうがいいです
  - 自分はマキタのDIYモデルである [マキタ 充電式ドライバドリル MDF347DS](https://www.amazon.co.jp/%E3%83%9E%E3%82%AD%E3%82%BF-Makita-MDF347DS-%E5%85%85%E9%9B%BB%E5%BC%8F%E3%83%89%E3%83%A9%E3%82%A4%E3%83%90%E3%83%89%E3%83%AA%E3%83%AB/dp/B077K34PSH?&linkCode=ll1&tag=naoina09-22&linkId=74b30987a416152b059a7dd97aa91198&language=ja_JP&ref_=as_li_ss_tl) を買いました
  - ホームセンターなどでレンタルしてもいいかもしれません
- 30mm ホールソー
  - ボタンの穴を開けるのに使います。純正Hit Boxで使われている24mmのボタンが良ければ24mmも買いましょう
  - ステップドリルでもいいと思います
- ニッパー
  - コードを切るのに使います。ハサミでもいいかもしれません
- 圧着ペンチ
  - 自分は [ホーザンP-706](https://www.amazon.co.jp/gp/product/B002TKG11G?ie=UTF8&psc=1&linkCode=ll1&tag=naoina09-22&linkId=a2804c84269e45882a0ce9ee0c0c231e&language=ja_JP&ref_=as_li_ss_tl) を使いました
- ワイヤーストリッパー
  - ニッパーやカッターでも被覆を剥けますが、あったほうが圧倒的に効率がいいです
  - 自分は [ベッセル3500E-2](https://www.amazon.co.jp/gp/product/B000CEAXM4?ie=UTF8&psc=1&linkCode=ll1&tag=naoina09-22&linkId=b3b318150e0f394c6cb4e2230485d795&language=ja_JP&ref_=as_li_ss_tl) を使いました
- ファストン端子 (平型端子) #110
  - 方向ボタンの配線を作るのに使います
  - すでに圧着してあるコードがあるならそちらを買ってもいいと思います
- 配線用コード
  - 方向ボタンの配線を作るのに使います
  - 自分はAWG20を買いましたが、ちょっと太かったのでAWG22か24を買ったほうがいいです
  - すでにファストン端子を圧着してあるコードがあるならそちらを買ってもいいと思います
- XHコネクタ
  - Qanba DroneのUSBコネクタがXHコネクタなので、それを分岐してSOCDクリーナーに5V電源とGNDを提供するために使います
- 熱収縮チューブ
  - USB配線のコネクタ変更での絶縁に使います
  - テープでもできなくはないですが、隙間があまりないので大変です
- 呼び径M3のネジとナイロン製六角ナット & 瞬間接着剤
  - SOCDクリーナーをマウントするために使います
  - SOCDクリーナーをアケコンのケースに留めない場合は必要ないです

<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoina09-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B077K34PSH&linkId=da297098882e313b5d57ce15d4a43721"></iframe>
<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoina09-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B009DZ2Q96&linkId=fbf8835a8bcb8e3522539dd3b85e0e8d"></iframe>
<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoina09-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B002TKG11G&linkId=03995cd221c417a064caa34f4953a240"></iframe>
<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoina09-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B000CEAXM4&linkId=d95e16448b7d6c60a6ef258a0f87a489"></iframe>
<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoina09-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B0876V1419&linkId=817e40da3bda7914762c3a026e18048c"></iframe>
<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoina09-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B071J1Z3CF&linkId=ebd53ebf00ddfed5a3d5a38a12f4c9ec"></iframe>
<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoina09-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B085QFT6YX&linkId=e5bfce18916c095830caa14dcaa8d761"></iframe>
<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoina09-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B077D5DQ9X&linkId=5a0316a828099cf6c0f78d9968cd6f2a"></iframe>
<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoina09-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B07V5TQ8NW&linkId=b35eb03e165085e84dc0abaab777ef9d"></iframe>

## ケースを開ける

まずQanba Droneのケースを開けます。
Qanba Droneはケースのネジを外してもレバーボールが引っかかって開かないのでレバーボールを取ります。
裏返すと手で回せる蓋があるので取り外します。

{{< figure src="qanba_drone_stick_hole.jpg" title="この蓋をOPENの方向に回して取る" >}}

レバーのマイナスネジ?が出てくるので、それをマイナスドライバーで抑えながらレバーボールを外します。抑えないとレバーが回ってしまってレバーボールが外せません。

{{< figure src="qanba_drone_stick_screw.jpg" title="これにマイナスドライバーを当てて抑えます" >}}

{{< figure src="qanba_drone_without_stick_ball.jpg" title="取れました" >}}

これでネジを外せばケースが開けられる状態になるので、再び裏返し、ネジを外してケースを開けます。

{{< figure src="qanba_drone_holes.jpg" title="この6箇所にあるプラスネジを外す" >}}

{{< figure src="qanba_drone_opened.jpg" title="開きました" >}}

## レバーとボタンを外す

レバーはネジで止まっているので外します。

{{< figure src="stick_board.jpg" title="この4箇所にあるプラスネジを外す" >}}

真ん中のネジはレバー本体の鉄板を止めているネジなので外さなくてOKです。
また、コードも外しますが、爪が付いているのでこれを上げながらコードを取り外します。

{{< figure src="stick_cord.jpg" title="この爪を上げないと取り外せない" >}}

取り外したコードは後で使うのでとっておきます。

レバーが取り外せたら、ボタンもすべて取り外します。
このとき、どのボタンにどのコードが対応しているのかをメモするか、写真に撮っておくと組み上げるときに調べながらやらなくていいので楽です。

{{< figure src="top_without_buttons.jpg" title="取り外した図" >}}

## 方向ボタン用の穴を開ける

電動ドライバドリルとホールソーを使います。レバーレス化において、唯一失敗すると取り返しがつかない工程なので慎重にやりましょう。

<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoina09-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B077K34PSH&linkId=da297098882e313b5d57ce15d4a43721"></iframe>
<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoina09-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B009DZ2Q96&linkId=fbf8835a8bcb8e3522539dd3b85e0e8d"></iframe>

自分は純正Hit Boxと同じ24mmではなく、全部30mmボタンにしたかったので30mmホールソーを使いましたが、ボタン間のクリアランスがかなりシビアになるので30mmで開けるのはおすすめしません。
レバーの穴はそのままで24mmボタンがきれいにハマるので、特にこだわりがなければ24mmの穴を開けるほうが色々と楽です。

表から開けるか裏から開けるかですが、裏から開けると表側にバリが出るので、できれば表から開けたほうがいいと思います。

{{< figure src="qanba_drone_made_holes.jpg" title="穴を開けました" >}}

自分は適当に目分量で穴を開けましたが、ちゃんとやるなら開ける穴のサイズに切った紙などでドリルのセンターを採って開けたほうがいいです。何度も言いますが、失敗すると取り返しがつきません。新しいQanba Droneを買うしかなくなるので慎重にやりましょう。

もうひとつ注意点があって、自分の指に合わせて穴を開けると、ケースの台側(レバーが固定されていたほう)の突起に干渉してボタンがハマらなかったりします。そうなると突起を切ったり削ったりする必要が出てくるので、それをやりたくない場合はケースの台側の突起を避けて穴を開けましょう。

穴を開けたら一旦ボタンを取り付けてケースを閉じてみます。干渉している場合は台側ケースの干渉している部分を切ったり削ったりします。

{{< figure src="qanba_drone_base_1.jpg" title="Qanba Droneの台側" >}}

自分の場合は、右ボタンと上ボタンが干渉しました。

{{< figure src="qanba_drone_base_2.jpg" title="右ボタンが干渉しないよう切ったところ" >}}

{{< figure src="qanba_drone_base_3.jpg" title="上ボタンが干渉しないよう切ったところ" >}}

自分はこのときニッパーとやすりで頑張ったのですが、ホットナイフを使ったほうが圧倒的に楽なのでこちらを使うことをおすすめします。

<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoina09-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B0016V7JII&linkId=9aba377a68a919b6296a50c4c8d9b8ad"></iframe>

## SOCDクリーナーを取り付ける

Qanba Droneの基板は標準で

- 上下同時押しは上優先
- 左右同時押しは左優先

となっているようなので、左右同時押しをニュートラルにするためにSOCDクリーナーを使います。もし上記で構わないのであれば必要ありません。が、離し波動や弾き波動[^3]を使いたい場合は必要です。

### 取り付け位置を決める

SOCDクリーナーをケースに固定する場合、Qanba Droneのケースでは各種配線や、今回付ける方向ボタンの都合により、使えるスペースは2箇所しかありません。

{{< figure src="socd_position_candidate.jpg" title="SOCDクリーナーをマウントする場所候補は2箇所" >}}

SOCDクリーナーは5VとGNDが必要なので、それらはUSB配線から持ってくる計画なので、基板のUSBコネクタが近い左側のスペースをSOCDクリーナーのマウント場所とすることにしました。

SOCDクリーナーを台側のケースに取り付けた場合、天板を外したときにSOCDに取り付けたコードか、基板側コネクタを外さないといけなくなるので、SOCDクリーナーは天板側に取り付けます。

Focus Attack SOCDクリーナーには3つネジ穴が付いているので、その位置で取り付けられるように呼び径M3のナイロン製六角ナットを瞬間接着剤で天板に付けます。

<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoina09-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B07V5TQ8NW&linkId=b35eb03e165085e84dc0abaab777ef9d"></iframe>

自分が買ったのは上記で、SOCDクリーナーの取り付けにはM3x6mmの高ナットと6mmのネジを使いました。

{{< figure src="socd_screw_position.jpg" title="M3x6mmの高ナットを接着剤で取り付ける" >}}

瞬間接着剤ではなくホットボンドで取り付けてもいいかもしれません。

### 5VとGNDを分岐するコードを作る

[千石電商](https://www.sengoku.co.jp/mod/sgk_cart/detail.php?code=EEHD-5UGM)か[叢雲商店](https://booth.pm/ja/items/3132340)で購入したSOCDクリーナーにはパワーハーネスという、既存のUSBコネクタから5VとGNDを分岐してSOCDクリーナーに提供できるコードが付いています。

{{< figure src="power_harness_1.jpg" title="これがパワーハーネス" >}}

これをそのまま使えれば話は早かったんですが、Qanba Droneの基板に付いているUSBコネクタはXHコネクタで、パワーハーネスのコネクタの形状とは違うのでコネクタを変更する必要があります。基板側を変更するのは大変なので、パワーハーネス側を変えます。

<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoina09-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B085QFT6YX&linkId=e5bfce18916c095830caa14dcaa8d761"></iframe>

かしめている端子を外すのは難しいため、コードを切断してXHコネクタを付けます。

{{< figure src="power_harness_2.jpg" title="スパッと" >}}

{{< figure src="power_harness_3.jpg" title="XHコネクタのメス端子をかしめてXHコネクタのハウジングを付ける" >}}

反対側ははんだ付けされているのですが、同じように切ってXHコネクタのオスを付けます。このとき5VとGNDを分岐するように2線を一緒にしますが、XHコネクタは向きがあるので、基板、USBケーブルのコネクタの5Vは5Vと、GNDはGNDに繋がるようにXHコネクタのハウジング向きを合わせる必要があります。

{{< figure src="power_harness_4.jpg" title="メス端子をかしめて挿すようにした" >}}

自分はこのときはんだ付けできる道具を持っていなかったので、メス端子をかしめてXHコネクタのオスに挿すようにしました。ですが、これだとケースを開いた際に結構抜けてしまうので、できればはんだ付けしたほうがいいです。
もし自分と同じ方式でやるならば、QIコネクタのメス端子 + ハウジングを使うとXHコネクタの基板側に挿すピンにいい感じで挿さります。

{{< figure src="power_harness_5.jpg" title="熱収縮チューブで絶縁する。見た目もよい" >}}

<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="//rcm-fe.amazon-adsystem.com/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=naoina09-22&language=ja_JP&o=9&p=8&l=as4&m=amazon&f=ifr&ref=as_ss_li_til&asins=B077D5DQ9X&linkId=5a0316a828099cf6c0f78d9968cd6f2a"></iframe>

ここまでできたらあとはSOCDクリーナーを天板に取り付けるだけです。

レバーを取り外した際に取っておいたコードと、先ほど作ったUSBの分岐コードをSOCDクリーナーに取り付け、天板に接着したM3の六角高ナットにM3x6mmのネジで止めます。

{{< figure src="socd_mount.jpg" title="SOCDクリーナーを取り付けた図" >}}

### 方向ボタン用配線を繋げる

まず方向ボタンとSOCDクリーナーを繋ぐ配線を作ります。
使うコードはAWS22のコードが多分太さ的に丁度いい気がします。そのコードに110型のファストン端子をかしめます。

{{< figure src="faston_terminal_1.jpg" title="いつも通りかしめる" >}}

{{< figure src="faston_terminal_2.jpg" title="かしめました" >}}

反対側は被覆を剥いただけでSOCDクリーナーに挿せるので、特になにか端子を圧着する必要はありません。
GND用のコードも同様に作成しますが、チェーンさせるように作っても、個別にSOCDにさせるように作っても構いません。

コードができたらSOCDクリーナーに接続します。

{{< figure src="socd_terminal_1.jpg" title="奥にある端子に被覆を剥いたコードを挟みます" >}}

プラスドライバーなどでへこんでいる部分を押すと、中の端子が開いてコードを挟み込めるようになります。

{{< figure src="socd_terminal_2.jpg" title="ここを押しながらコードを挿し込む" >}}

挿せたら軽く引っ張ってちゃんと固定されているかどうか確認しましょう。
ボタンのGNDをチェーンさせている場合はSOCDクリーナーの`G`と書いてあるところのどこか1つに挿せばOKです。

## 完成

ここまでできたらあとはすべてのボタンをはめ込み、配線をすれば完成です。

{{< figure src="qanba_drone_finished_1.jpg" title="すべて配線した図" >}}

{{< figure src="qanba_drone_finished_2.jpg" title="表側" >}}

[^1]: BrookのUniversal Fighting Boardであればはんだ付けは必要ないです。
[^2]: PC版だとSteam側でコントローラーのボタン割当を変えればできなくはない
[^3]: https://note.com/takahata88/n/n2a6c6ee41cdc
