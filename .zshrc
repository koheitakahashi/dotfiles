# Fig pre block. Keep at the top of this file.

# # ------------------------------------
# 環境変数
# -------------------------------------
export EDITOR='vim'

export PATH="$HOME/.rbenv/shims:$PATH"
export PATH="~/.rbenv/shims:/usr/local/bin:$PATH"
eval "$(rbenv init -)"

export PATH=$HOME/.nodebrew/current/bin:$PATH

export PATH=$PATH:~/bin
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin
eval "$(gh completion -s zsh)"

# starshipの設定ファイルのパス
export STARSHIP_CONFIG=~/.starship/.config/starship.toml

# fzfのデフォルトのオプションを指定
export FZF_DEFAULT_OPTS='--color=fg+:11 --height 70% --reverse --select-1 --exit-0 --multi'

export FZF_CTRL_T_OPTS="--preview 'tree -C {} | head -200'"

eval "$(anyenv init -)"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="/usr/local/opt/openssl@3/bin:$PATH"

# iterm の shell integratin
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

# -------------------------------------
# zshのオプション
# -------------------------------------

## 入力しているコマンド名が間違っている場合にもしかして：を出す。
setopt correct

# ビープを鳴らさない
setopt nobeep

## バックグラウンドジョブが終了したらすぐに知らせる。
setopt no_tify

## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups

# 補完
## タブによるファイルの順番切り替えをしない
unsetopt auto_menu

# 同時に起動したzshの間でヒストリを共有する
setopt share_history
setopt HIST_IGNORE_DUPS
export SAVEHIST=100000
setopt hist_verify
setopt hist_reduce_blanks
setopt hist_no_store

#aliasを展開して補完
unsetopt COMPLETE_ALIASES

# lsコマンドの補完候補にも色付き表示
zstyle ':completion:*:default' list-colors ${LS_COLORS}

# kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

# -------------------------------------
# Iterm2関連
# -------------------------------------

## 画面を4分割
function split_window() {
osascript << EOF
tell application "iTerm"
  activate

  tell current session of current window
    split vertically with default profile
    split horizontally with default profile
  end tell

  tell last session of current tab of current window
    select
    split horizontally with default profile
  end tell

end tell
EOF
}
zle -N split_window
bindkey "\eh" split_window

# -------------------------------------
# zint
# ref: https://qiita.com/crossroad0201/items/17270127732dc20fa8b2
# -------------------------------------

# Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
   print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
  command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
  command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
      print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
      print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完候補を一覧表示したとき、Tabや矢印で選択できるようにする
zstyle ':completion:*:default' menu select=1

## シンタックスハイライト
zinit light zsh-users/zsh-syntax-highlighting

## -------------------------------------
## zintの拡張
## ref: https://qiita.com/crossroad0201/items/17270127732dc20fa8b2
## -------------------------------------

# コマンド補完
zinit ice wait'0' lucid ; zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-completions

autoload -Uz compinit && compinit

# 履歴補完
zinit light zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=244"

# クローンしたGit作業ディレクトリで、コマンド `git open` を実行するとブラウザでGitHubが開く
zinit light paulirish/git-open

# iTerm2を使っている場合に、コマンド `tt タブ名` でタブ名を変更できる
zinit light gimbo/iterm2-tabs.zsh

# Gitの変更状態がわかる ls。ls の代わりにコマンド `k` を実行するだけ。
zinit light supercrabtree/k


export _GHF_FZF_VIEWER="url"
# -------------------------------------
# fzf関連のコマンド
# -------------------------------------

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# コマンドの実行履歴を表示
function fzf-history-widget() {
    local tac=${commands[tac]:-"tail -r"}
    BUFFER=$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | sed 's/ *[0-9]* *//' | eval $tac | awk '!a[$0]++' | fzf +s)
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N fzf-history-widget
bindkey '\eh\ei' fzf-history-widget

# ghqでクローンしたGitリポジトリを表示
function ghq-fzf() {
  local src=$(ghq list | fzf --preview "ls -laTp $(ghq root)/{} | tail -n+4 | awk '{print \$9\"/\"\$6\"/\"\$7 \" \" \$10}'")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '\eg\eh' ghq-fzf

# 選択したPRにcheckout
function checkout-pull-request () {
    local selected_pr_id=$(gh pr list | fzf | awk '{ print $1 }')
    if [ -n "$selected_pr_id" ]; then
        BUFFER="gh pr checkout ${selected_pr_id}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N checkout-pull-request
bindkey '\eg\ep' checkout-pull-request

# webで開きたいPRを選択することができる
function view-pull-request () {
    local selected_pr_id=$(gh pr list | fzf | awk '{ print $1 }')
    if [ -n "$selected_pr_id" ]; then
        BUFFER="gh pr view --web ${selected_pr_id}"
        zle accept-line
    fi
    zle clear-screen
}

zle -N view-pull-request
bindkey '\eg\ev' view-pull-request

# lsみながらcdrする
function select_cdr(){
    local selected_dir=$(cdr -l | awk '{ print $2 }' | \
      fzf --preview 'f() { sh -c "tree $1" }; f {}')
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N select_cdr
bindkey '\el\eh' select_cdr

autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# -------------------------------------
# alias
# -------------------------------------

## -------------------------------------
## linuxコマンドなど
## -------------------------------------

alias ls="ls -GF"
alias ll="ls -al"
alias cat="bat"
alias findd="fd"
alias grep="rg"

# edit zshrc
alias viz='vim ~/.zshrc'
alias vizp='vim ~/.zsh_profile'

# starshipの設定ファイルを編集
# ref: https://starship.rs/ja-JP/config/
alias vis='vim ~/.starship/.config/starship.toml'

# icouldに移動
alias cdic='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs'

## -------------------------------------
## Git関連
## -------------------------------------

alias g='git'
alias gpl='git pull'
alias gps='git push'
alias gsw='git switch'
alias gswc='() { git switch -c $1 }'

# 開発中のブランチを持ってくる時は gcob hoge origin/hoge
alias gl='git log --oneline'

# 強制 pull
alias gplf='() { git fetch origin $1 | git reset --hard origin/$1 }'

# git rebase系
alias grb='git rebase'
alias grbm='git rebase master'
alias grbi='git rebase -i'
alias grbc='git rebase --continue'
alias grbs='git rebase --skip'
alias grba='git rebase --abort'

# stash系
alias gst='git stash'

# 退避した作業を戻す [git stash apply stash@{0}]
alias gstap='(){ git stash apply stash@{$1} }'
alias gstpop='(){ git stash pop stash@{$1} }'

alias gpsfw\ origin\ master='git log'

# リモートとローカルのブランチを比較して、ローカルの更新日付が新しい時のみpush成功
alias gpsfw='git push --force-with-lease'

# lazygit
alias lg='lazygit'

alias gop='git open'

## -------------------------------------
## Ruby・Rails関連
## -------------------------------------

# bundle
alias be='bundle exec'
alias b='bundle'
alias bi="bundle config set --local  path 'vendor/bundle' && bundle install"

alias r='bin/rails'

# credentialsを作成
alias credentials:edit='EDITOR="vi" bin/rails credentials:edit'

alias ws='bin/webpack-dev-server'

# homebrew
alias brwi='brew install'

alias opl='open http://localhost:3000'

# docker
alias dk='docker'
alias dcc='docker compose'

# -------------------------------------
# その他
# -------------------------------------

function chpwd() { ls -1 }

alias hrunb="heroku run bash -a" # bash で heroku にアクセス
alias ct='code ~/tmp/memo.md'

# -------------------------------------
# starship
# -------------------------------------

eval "$(starship init zsh)"
