+++
date = "2016-05-11T19:57:41+09:00"
draft = false
logo = ""
logosmall = ""
"tags" = ["mlterm", "tmux"]
title = "mlterm 上の tmux で罫線を正しく表示する設定"

+++

tmux 2.1 以降と mlterm の組み合わせで、tmux で pane を分割したときに下図のように罫線が二重になってしまうことがあります。

{{< img src="d586852.png" alt="d586852" >}}

これを解決するには `.mletrm/main` に下記を設定する

```
box_drawing_font = decsp
```

もしくは mlterm 上で Ctrl+右クリック して設定 UI から `罫線` の `DEC Specialに変換` を選択

{{< img src="e020979.png" alt="e020979" >}}

これで正常に罫線が表示されるようになります。

{{< img src="224eb19.png" alt="224eb19" >}}
