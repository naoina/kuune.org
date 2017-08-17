+++
title = "Re:VIEWのALE linterを作った"
date = 2017-08-18T00:45:39+09:00
draft = false
"text/tags" = ["ALE", "Neovim", "Vim", "Re:VIEW"]
logo = ""
logosmall = ""
+++

[以前紹介したALE]({< relref "./how-to-lint-and-autoformat-with-ale.md" >})の[Re:VIEW](https://github.com/kmuto/review)用linterを作りました。

https://github.com/naoina/ale-linter-review

`runtimepath`が通っているところに置くか、[Vundle](https://github.com/VundleVim/Vundle.vim)とか[vim-plug](https://github.com/junegunn/vim-plug)とか[dein.vim](https://github.com/Shougo/dein.vim)使ってインストールしてください。
`review-compile`というALE linterとして登録しているので、次のように`review`というファイルタイプに`review-compile`を指定してください。

```vim
let g:ale_linters = {
\ 'review': ['review-compile'],
\ }
```

ファイルタイプの判定は[vim-review](https://github.com/moro/vim-review)を入れると便利かもしれません。
