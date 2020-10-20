+++
title = "Zshのglobaliasでgitのエイリアスを展開する"
date = 2020-10-20T17:48:12+09:00
draft = false
"text/tags" = ["zsh", "globalias"]
+++

## はじめに

ZshのOh My Zshのプラグインのひとつにglobaliasというものがあります。

https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/globalias

これはZshで設定したエイリアスを半自動で元のコマンドに展開してくれるものです。

{{< figure src="zsh-globalias.gif" caption="画像元:" attr="Pat's Blog" attrlink="https://blog.patshead.com/2012/11/automatically-expaning-zsh-global-aliases---simplified.html" >}}

主な用途としては、他人にコマンドを共有する場合に自前でエイリアス展開をしなくてよくなるので便利です。
便利なのですが、展開してくれるエイリアスは当然Zshのものだけで、Gitのエイリアスは展開してくれません。個人的にGitのエイリアスも同じように展開してほしかったのでオリジナルのglobaliasを元に書きました。

## コード

```zsh
function globalias() {
    local args=(${(Az)LBUFFER})
    local cmd=$args[1]
    case "$cmd" in
        git)
            cmd="$(git config --get "alias.$args[2]" 2>/dev/null)"
            if [[ "$cmd[1]" = "!" ]]; then
                cmd=(${(Aps: :)"${cmd:1}"})
                args[1]=${cmd[1]}
                args[2]=${cmd:1}
                LBUFFER="$args"
            elif [[ -n "$cmd" ]]; then
                args[2]="$cmd"
                LBUFFER="$args"
            fi
            ;;
        *)
            ;;
    esac
    local word=$args[-1]
    zstyle -a ':globalias:var' filters filters
    [[ -n "$filters" ]] || filters=()
    if [[ $filters[(Ie)$word] -ne 0 ]]; then
        zle _expand_alias
        zle expand-word
    fi
    if [[ "$KEYS" = ' ' ]]; then
        zle self-insert
    else
        zle accept-line
    fi
}
zle -N globalias

bindkey -M emacs " " globalias
bindkey -M viins " " globalias

bindkey -M emacs "^M" globalias
bindkey -M viins "^M" globalias
```

オリジナルのgloabaliasとの主な変更点は下記です。

- Gitのエイリアスを展開できるようにした
- 環境変数ではなく `:globalias:var` で対象を設定するようにした
- `:globalias:var` で設定した対象は展開するものを設定するようにした
- エイリアスの展開をコマンド実行時（正確には^Mを押下した時）にも行うようにした

## ちょっと解説

### Gitのエイリアスを展開できるようにした

下記の部分で行っています。

```zsh
local args=(${(Az)LBUFFER})
local cmd=$args[1]
case "$cmd" in
    git)
        cmd="$(git config --get "alias.$args[2]" 2>/dev/null)"
        if [[ "$cmd[1]" = "!" ]]; then
            cmd=(${(Aps: :)"${cmd:1}"})
            args[1]=${cmd[1]}
            args[2]=${cmd:1}
            LBUFFER="$args"
        elif [[ -n "$cmd" ]]; then
            args[2]="$cmd"
            LBUFFER="$args"
        fi
        ;;
    *)
        ;;
esac
```

正確には展開ではなく置換しています。Gitのエイリアスには `!` で始まるシェルスクリプトが書けるものと、Gitコマンドのみが書ける2種類がありますが、両方対応しています。

まず `git` で始まる場合に下記でエイリアスを取得します。

```zsh
cmd="$(git config --get "alias.$args[2]" 2>/dev/null)"
```

取得したエイリアスが `!` から始まる場合はシェルスクリプトなので、エイリアスとそれより前に入力されたコマンドをまるごと置き換えます。

```zsh
cmd=(${(Aps: :)"${cmd:1}"}) # スペース区切りで分割して配列にする
args[1]=${cmd[1]} # コマンドを置き換える
args[2]=${cmd:1} # 後続の引数を置き換える
LBUFFER="$args"
```

例えば

```git
g = !zsh -c 'git grep -P \"$@\" | fzf' -
```

というエイリアスがある場合は `git g` が

```zsh
% !zsh -c 'git grep -P \"$@\" | fzf' -
```

に展開されます。

取得したエイリアスが `!` で始まるもの以外の場合はGitコマンドなので、そのエイリアスだけを置き換えます。

```zsh
args[2]="$cmd"
LBUFFER="$args"
```

例えば

```git
g = grep -P
```

というエイリアスがある場合は `git g` が

```zsh
% git grep -P
```

に展開されます。

該当するエイリアスがない場合は展開しません。

### 環境変数ではなく `:globalias:var` で対象を設定するようにした

下記の部分です。

```zsh
zstyle -a ':globalias:var' filters filters
[[ -n "$filters" ]] || filters=()
```

オリジナルは `GLOBALIAS_FILTER_VALUES` という環境変数で行うようになってますが、オシャレにzstyleを使うようにしました。オシャレ以外の理由は特にありません。

設定は

```zsh
zstyle ':globalias:var' filters (ls df du)
```

のように、展開するエイリアスを設定します。自分は

```zsh
function ealias() {
    alias $@
    local args="$@"
    args=${args%%\=*}
    zstyle -a ':globalias:var' filters filters
    filters+=(${args##* })
    zstyle ':globalias:var' filters $filters
}
```

という関数を用意して、展開したいエイリアスを

```zsh
ealias gp="git pull"
```

と定義しています。

### `:globalias:var` で設定した対象は展開するものを設定するようにした

下記の部分です。

```zsh
if [[ $filters[(Ie)$word] -ne 0 ]]; then
```

`-eq` を `-ne` に変えただけです。オリジナルのglobaliasは指定したものを展開 **しない** 設定でしたが、逆に、設定したものを展開するように変えています。

### エイリアスの展開をコマンド実行時（正確には^Mを押下した時）にも行うようにした

下記と

```zsh
if [[ "$KEYS" = ' ' ]]; then
    zle self-insert
else
    zle accept-line
fi
```

さらに下記の部分です。

```zsh
bindkey -M emacs "^M" globalias
bindkey -M viins "^M" globalias
```

これは、

```zsh
git st
```

のような、追加で引数やオプションを指定しないエイリアスコマンドの場合に、スペースを押下しなくても展開できるようにしています。

##

以上、ちょっと解説でした。
