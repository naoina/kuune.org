+++
date = "2017-05-14T01:18:42+09:00"
draft = false
logo = ""
logosmall = ""
"text/tags" = ["jupyter", "ssh"]
title = "サーバー上の Jupyter Notebook を SSH Port Forwarding を通して使う"

+++

[Jupyter Notebook](http://jupyter.org/) という便利なものがあるのでよく使っているんですが、CPU を使う処理をする際にローカル PC で動かすと他に何もできなくなるし、何よりファンの音がうるさい。そこでクラウドサーバーなどリモートサーバーで実行するんですが、デフォルトだと localhost からしかアクセスできないようになっています。かといって

```bash
jupyter notebook --ip=0.0.0.0
```

などとすると、今度はファイアウォールの設定をしたくなります。また、このままだと平文なのでアレです。Jupyter はいちおう SSL 通信できるようにもできるんですが、鍵を作ったり管理したりしないといけないので面倒です。そこで、ssh の port forwarding を使って手軽にセキュアに使えるようにします。

まず下記で localhost:8888 に繋げばリモートホストの 8888 にポートフォワードするようにします。

```bash
ssh -L 8888:localhost:8888 ubuntu@example.com
```

同時に ssh でログインできるので、そのままリモートホスト上で Jupyter Notebook を立ち上げます。このとき `--ip` オプションは必要ないです。

```bash
jupyter notebook
```

これで、ローカル PC のブラウザで http://localhost:8888 に繋げばリモートホスト側の Jupyter Notebook にアクセスできるようになります。URL は http ですが、ssh port forwarding でトンネル掘ってるので実質暗号通信になってます。この方法を使えば、ssh で繋げるようになってさえいれば特別な設定なしで Jupyter Notebook をセキュアに使えます。
