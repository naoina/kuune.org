+++
date = "2015-02-16T00:03:34+09:00"
draft = false
title = "naoina/toml を TOML v0.4.0 に準拠させた"

+++

以前 golang 用の TOML パーサー( https://github.com/naoina/toml )を作りましたが、今回これを TOML 0.4.0 に準拠させていくつかのバグを修正しました。
golang 用の TOML パーサーには他に https://github.com/BurntSushi/toml がありますが、これと違う点としては、パーサーを [PEG](http://ja.wikipedia.org/wiki/Parsing_Expression_Grammar) から生成しているのと、TOML ファイルにエラーがある場合のメッセージを分かりやすくするようにしている点です。

あと、現在はデコーダーしか実装していないので TOML ファイルから Go の struct にマッピングはできますが、逆に Go の struct から TOML ファイルを生成することはできません。
別にエンコーダーの実装が難しいというわけではなくて、単に必要に迫られてないので実装してないだけです。issues か pull request がきたら実装すると思います。
