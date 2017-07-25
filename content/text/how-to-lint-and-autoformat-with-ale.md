+++
title = "ALEでソースコードのLint/自動整形する"
date = 2017-07-23T18:47:29+09:00
draft = false
tags = ["Vim", "NeoVim", "ALE", "lint", "format"]
logo = ""
logosmall = ""
+++

## ALEとは

https://github.com/w0rp/ale

*Asynchronous Lint Engine (ALE)* という名の通り、Vim/NeoVim用の非同期Lintエンジンです。VimのLintエンジンといえば[Syntastic](https://github.com/vim-syntastic/syntastic)がよく知られているのではないかと思いますが、Syntasticは同期的にLintを行うのでLint中はカーソル移動や編集などができません。ALEは非同期でLintを行うのでLint中もカーソル移動や編集ができるので、Lintをかけるたびに一定時間待たなければいけないという問題を回避できます。

## ソースコードのLint

ALEのデフォルトのままでも開いているファイルのファイルタイプで使えるLinterが入ってさえいれば特に設定せずにLintが走ります。デフォルトでLintが走るタイミングは。

1. ファイルを開いたとき
1. ファイルを保存したとき
1. テキストが変更された（`TextChanged`イベントが飛んだ）とき

となっています。個人的にはテキストが変更されただけでLintが走るのは頻度が高すぎると感じるのでそれだけオフにしています。

![3ef40dc3c9e8b303934f4b19149da94eb7046e89](/image/3ef40dc3c9e8b303934f4b19149da94eb7046e89.gif)

以下私が使っている設定を抜粋します。

```vim
let g:ale_lint_on_text_changed = 0
let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ }
```

`g:ale_linters`を設定することで、特定のファイルタイプに対してLinterを指定できます。

## ソースコードの自動整形

さらにALEにはLint以外にも自動整形できる機能があります。それを使えば自動整形もALEに統一できるため、自動整形用のプラグインを個別に入れなくて済むようになります。

![3555ee8e7db9e4e53a4243d139257c2d9c6a7b27](/image/3555ee8e7db9e4e53a4243d139257c2d9c6a7b27.gif)

私が使っている設定を抜粋します。

```vim
let g:ale_fixers = {
      \ 'javascript': ['prettier'],
      \ 'python': ['autopep8', 'isort'],
      \ 'markdown': [
      \   {buffer, lines -> {'command': 'textlint -c ~/.config/textlintrc -o /dev/null --fix --no-color --quiet %t', 'read_temporary_file': 1}}
      \   ],
      \ }
let g:ale_fix_on_save = 1
```

ALEでは自動整形するもののことをfixerといいます。ALEにはすでに定義されているfixers[^1]がいくつかあり、`g:ale_fixers`で指定できます。ALEにないfixersでも上記の`markdown`用のfixerのように自前で定義できます。また、`g:ale_fix_on_save`を`1`にすれば保存のたびに自動整形がかけられます。自動整形も非同期で行われるのですが、こちらはコードが書き換わるので自動整形中に編集することはできません（カーソル移動は問題ないです）。

## まとめ

日本語のALEの記事をほとんど見かけないので、ALEは良いよという話をしたかった。

[^1]: https://github.com/w0rp/ale/tree/v1.4.x/autoload/ale/fixers
