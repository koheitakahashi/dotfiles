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

# iTerm2 の shell integratin
source ~/.iterm2_shell_integration.fish

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
