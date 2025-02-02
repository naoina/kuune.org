+++
date = "2013-06-03T12:22:56+09:00"
draft = false
title = "PythonistaはPEP8を読もう"
"tags" = ["python"]

+++

タイトル通りです。[PEP 8][PEP 8] にはPythonistaの全てが詰まっている。クリスチャンが聖書を何度も読むように、Pythonistaも [PEP 8][PEP 8] を何度も読むべきだ。
以下蛇足。

最近 [PEP 8][PEP 8] を原文で読んでいて、[日本語訳](http://oldriver.org/python/pep-0008j.html) と違う部分がありました。
[Other Recommendations](http://www.python.org/dev/peps/pep-0008/#other-recommendations) の部分なんですが、原文だと

Yes:

```
i = i + 1
submitted += 1
x = x*2 - 1
hypot2 = x*x + y*y
c = (a+b) * (a-b)
```

No:

```
i=i+1
submitted +=1
x = x * 2 - 1
hypot2 = x * x + y * y
c = (a + b) * (a - b)
```

と書いてあるのに対し、日本語訳だと

○

```
i = i + 1
submitted += 1
x = x * 2 - 1
hypot2 = x * x + y * y
c = (a + b) * (a - b)
```

×

```
i=i+1
submitted +=1
x = x*2 - 1
hypot2 = x*x + y*y
c = (a+b) * (a-b)
```

と書いてあったわけです。概ね真逆なんですね。これ、どういうことかというと、翻訳当時とはPEP8の内容が変わってるということでした。
具体的には http://hg.python.org/peps/rev/37af28ad2972 のチェンジセットで文言が変わって、間違っていたexampleが http://hg.python.org/peps/rev/16dd63848921 のチェンジセットで修正されたということみたいです。
というかPEPのリポジトリがあるのを今回のことで初めて知ったのでPEP8の変更履歴を見てみましたが、割と変更されてて驚きました。

[PEP 8]: http://www.python.org/dev/peps/pep-0008
