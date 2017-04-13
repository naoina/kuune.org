+++
date = "2015-12-09T22:54:32+09:00"
publishdate = "2015-12-09T22:54:32+09:00"
draft = false
title = "Custom anyframe-widget-cd-ghq-repository"
tags = ["zsh", "anyframe", "ghq"]

+++

zsh には [anyframe][] という [peco](https://github.com/peco/peco)/[percol](https://github.com/mooz/percol)/[fzf](https://github.com/junegunn/fzf) を便利に使うためのライブラリがあって、中でも **anyframe-widget-cd-ghq-repository** を便利に、それはもう便利に使っていました。
ですが、中で `ghq list --full-path` を使っていて自分のリポジトリを絞り込もうと思っても簡潔にできなかったので自前で plugin 書かきました。

自分はユーザー名をハンドルそのままの `naoina` を使っているので、リポジトリのユーザー名とかぶります。

![before](/image/anyframe-peco-ghq-before.gif)

なので、下記のようにして `ghq root` より後のパスで絞りこめるようにしました。

```zsh
# zsh/anyframe-functions/sources/anyframe-source-ghq-repository-relative-path
ghq list
```


```zsh
# .zsh/anyframe-functions/widgets/anyframe-widget-cd-ghq-repository-relative-path
anyframe-source-ghq-repository-relative-path \
  | anyframe-selector-auto \
  | awk "{ print \"$(ghq root)/\" \$1 }" \
  | anyframe-action-execute cd --
```

```zsh
# .zshrc
fpath=($HOME/.zsh $fpath)
alias r="anyframe-widget-cd-ghq-repository-relative-path"
```

![after](/image/anyframe-peco-ghq-after.gif)

[anyframe][] は自前で plugin を簡単に書けるのでいいですね。

[anyframe]: https://github.com/mollifier/anyframe
