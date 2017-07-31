+++
date = "2013-05-24T20:10:14+09:00"
draft = false
title = "flight-mocha作りました"
"text/tags" = ["flight", "javascript", "mocha"]

+++

https://github.com/naoina/flight-mocha

Twitter社製の [Flight](http://twitter.github.io/flight/) という素晴らしいJavaScriptのフレームワークがありまして、このplogでも使っています。

JavaScriptのテストはいつも [mocha](http://visionmedia.github.io/mocha/) + [expect.js](https://github.com/LearnBoost/expect.js/) でやっているのですが、今回だけ [flight-jasmine](https://github.com/twitter/flight-jasmine) があるのでjasmineで書こうとしました。
が、jasmineの非同期テストがあまりにもダサすぎて使う気にならなかったのでカッとなって作りました。

- plogのテスト書こう
  ↓
- Flightのヘルパー関数書くの面倒
  ↓
- flight-jasmine使おう
  ↓
- jasmineの非同期テストダサすぎ
  ↓
- そうだflight-mocha作ろう
  ↓
- 出来た←イマココ

こんな感じです。

また、現状ではFlightのイベント周りのテストは [sinon.js](http://sinonjs.org/) あたりを使って自力でやる必要があります。
なので、ここらへんをflight-mochaでうまくやれないかなと考えていますがそれはまた別のお話。
