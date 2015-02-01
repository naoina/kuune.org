+++
date = "2014-08-20T13:55:22+09:00"
draft = false
title = "Travis-CI で Windows バイナリをテストする"

+++

<blockquote class="twitter-tweet" lang="en"><p>travis-ciでapi-getでwine突っ込んでやったらwindows環境でのテストできるのでは？</p>&mdash; 7017 (@naoina) <a href="https://twitter.com/naoina/statuses/498832759981240321">August 11, 2014</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

できました。

https://github.com/naoina/travis-win-test

```yaml
language: go

go:
  - 1.3

before_install:
  - sudo apt-get update -qq
  - sudo apt-get install -y wine

install:
  - gvm cross windows 386

script:
  - GOOS=windows GOARCH=386 go test -c
  - wine travis-win-test.test.exe
```

https://github.com/naoina/travis-win-test/blob/master/.travis.yml

宗教上の理由で Golang を使いましたが、MinGW などのクロスコンパイラを用いても同様にできると思います。
 
このように Travis-CI を用いる場合でも Windows バイナリのテストが行えることが分かりましたので、Gopher の皆様におかれましては Golang のクロスコンパイルの手軽さを活かして Windows 対応をしてみてはいかがでしょうか？
