# ==============================
# BaseSettings
# ==============================

# Environment variable

# history
HISTFILE=$HOME/.zsh-history
HISTSIZE=10000
SAVEHIST=10000

# -------------------------------------
# zsh options
# -------------------------------------

# 色を使用
autoload -Uz colors
colors

## 補完機能の強化
autoload -U compinit
compinit

# lsの色つけ
unset LANG
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors "${LS_COLORS}"

alias ls="ls -G"
alias gls="gls --color"

# 入力しているコマンド名が間違っている場合にもしかして：を出す。
setopt correct

# ビープを鳴らさない
setopt nobeep

## 色を使う
setopt prompt_subst

## ^Dでログアウトしない。
setopt ignoreeof

## バックグラウンドジョブが終了したらすぐに知らせる。
setopt no_tify

## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups

# 補完
## タブによるファイルの順番切り替えをしない
unsetopt auto_menu

# cd -[tab]で過去のディレクトリにひとっ飛びできるようにする
setopt auto_pushd

# ディレクトリ名を入力するだけでcdできるようにする
setopt auto_cd

# ==============================
# VCSSettings
# ==============================

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%F{white}%K{green}%s%f%k)-[%F{white}%K{blue}%b%f%k]'
zstyle ':vcs_info:*' actionformats '(%F{white}%K{green}%s%f%k)-[%F{white}%K{blue}%b%f%k|%F{white}%K{red}%a%f%k]'

precmd() {
  local left='\-[%B%n%b%F{cyan}@%f%B%m%b]'
  # バージョン管理されてた場合、ブランチ名
  vcs_info
  local right="${vcs_info_msg_0_}-[%K{magenta}%d%k]"

  local invisible='%([BSUbfksu]|([FK]|){*})'
  local leftwidth=${#${(S%%)left//$~invisible/}}
  local rightwidth=${#${(S%%)right//$~invisible/}}
  local padwidth=$(($COLUMNS - ($leftwidth + $rightwidth)))

  print -P $left-$right${(r:$padwidth::-:)}
}
# %(1j,(%j),) : 実行中のジョブ数が1つ以上ある場合ジョブ数を表示
PROMPT='-%(1j,(%j),)%B%#%b '
#RPROMPT='[%K{magenta}%d%k]'

# ==============================
# Extensions
# ==============================

# 入力補完
## git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# ==============================
# EnvSettings
# ==============================

export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

# alias
# rm,cp,mvするときは確認
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

alias l="ls -l"
alias ll="ls -l"
alias la="ls -la"

# grepの設定 n:行番号の表示
alias grep="grep -n --color=auto"

# 文字コードの指定
export LANG='ja_JP.UTF-8'
export LESSCHARSET=utf-8
