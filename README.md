# dotfiles
## 概要

自分の設定ファイルを集めたディレクトリ。基本的な使い方としては、各種シンボリックリックをホームディレクトリ配下などに貼っていく。

## 初期設定
### 各種設定ファイルのシンボリックリンクを貼る

```
ln -s ./.zshrc ~/.zshrc
ln -s ./.vimrc ~/.vimrc
ln -s ./.fzf.zsh ~/.fzf.zsh
ln -s ./.gitconfig ~/.gitconfig
ln -s ./.gitignore_global ~/.gitignore_global
ln -s ./.starship ~/.starship
ln -s ./.Brewfile ~/.Brewfile
ln -s ./bin ~/bin
ln -s ./com.googlecode.iterm2.plist ~/com.googlecode.iterm2.plist
ln -s ./fish .config/
```

### .gitconfig

.gitconfig は会社とプライベートで署名に残す Email を変えたいため、sample をおいて、それぞれの PC で書き換えることを想定している。.gitconfig_sample をコピーして、.gitconfig に rename して書き換え。その後ホームディレクトリに置く。

### iterm2 の shell 統合

ref: [Shell Integration \- Documentation \- iTerm2 \- macOS Terminal Replacement](https://iterm2.com/documentation-shell-integration.html)

```shell
curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash

curl -L https://iterm2.com/shell_integration/zsh \
-o ~/.iterm2_shell_integration.zsh
```

### .fzf.zsh

M1 と Intel Mac で fzf がインストールされている場所のパスが異なるため、work と private にそれぞれ .fzf.zshを配置している。
環境構築時はそのパスでシンボリックリンクを作成する。

## bin/ 自作スクリプト

[bin配下のスクリプト一覧](./bin/README.md)
