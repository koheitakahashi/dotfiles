# --------
# 環境変数
# --------
set -gx EDITOR vim
set -gx FZF_LEGACY_KEYBINDINGS 0
set -gx LESS -g -i -M -R -S -W -z-4 -x4
set -gx GOPATH $HOME
set -gx FZF_LEGACY_KEYBINDINGS 0

# starshipの設定ファイルのパス
set -gx STARSHIP_CONFIG ~/.starship/.config/starship.toml

# --------
# abbr
# --------
abbr -a -- c code
abbr -a -- cm 'code ./tmp/memo.md'
abbr -a -- bu bundle
abbr -a -- be 'bundle exec'
abbr -a -- dkc 'docker compose'
abbr -a -- dk docker
abbr -a -- g git
abbr -a -- gpro 'git branch --show-current | gh pr view --web'
abbr -a -- gpl 'git pull'
abbr -a -- ghv 'gh repo view -w' 
abbr -a -- gst 'git stash'
abbr -a -- glo 'git log --oneline'
abbr -a -- gsw 'git switch'
abbr -a -- gswc 'git switch -c'
abbr -a -- gps 'git push'
abbr -a -- gpsoh 'git push origin HEAD'
abbr -a -- gpsfw 'git push --force-with-lease'
abbr -a -- gop open_github_pr
abbr -a -- less 'less -R'
abbr -a -- opl 'open http://localhost:3000'
abbr -a -- lg lazygit
abbr -a -- cdic cd\ /Users/koheitakahashi/Library/Mobile\\\ Documents/com\~apple\~CloudDocs
abbr -a -- e 'exa'
abbr -a -- ef 'exa -F'
abbr -a -- el 'exa -al'
abbr -a -- b bat
abbr -a -- r bin/rails
abbr -a -- v vim
abbr -a -- ws bin/webpack-dev-server

# --------
# function
# --------
# shell 起動時にメッセージを出さない
function fish_greeting
end

function fzf
  command fzf --height 70% --reverse --border $argv
end

function fish_user_key_bindings
  bind \cg __ghq_repository_search
end

# --------
# その他
# --------
eval "$(starship init fish)"
eval (gh completion -s fish| source)

source /opt/homebrew/opt/asdf/libexec/asdf.fish

# iTerm2 の shell integratin
source ~/.iterm2_shell_integration.fish

