# dotfiles
## 概要

自分の設定ファイルを集めたディレクトリ。基本的な使い方としては、各種シンボリックリックをホームディレクトリ配下などに貼っていく。
## 環境構築手順
### 1. 設定ファイルの設置
#### 各種設定ファイルのシンボリックリンクを貼る

```
ln -s ~/dev/github.com/koheitakahashi/dotfiles/.zshrc ~/.zshrc
ln -s ~/dev/github.com/koheitakahashi/dotfiles/.vimrc ~/.vimrc
ln -s ~/dev/github.com/koheitakahashi/dotfiles/.fzf.zsh ~/.fzf.zsh
ln -s ~/dev/github.com/koheitakahashi/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dev/github.com/koheitakahashi/dotfiles/.gitignore_global ~/.gitignore_global
ln -s ~/dev/github.com/koheitakahashi/dotfiles/.starship ~/.starship
ln -s ~/dev/github.com/koheitakahashi/dotfiles/.Brewfile ~/.Brewfile
ln -s ~/dev/github.com/koheitakahashi/dotfiles/bin ~/bin
ln -s ~/dev/github.com/koheitakahashi/dotfiles/com.googlecode.iterm2.plist ~/com.googlecode.iterm2.plist
ln -s ~/dev/github.com/koheitakahashi/dotfiles/fish .config/
ln -s ~/dev/github.com/koheitakahashi/dotfiles/karabiner ~/
```

#### .gitconfig

.gitconfig は会社とプライベートで署名に残す Email を変えたいため、sample をおいて、それぞれの PC で書き換えることを想定している。.gitconfig_sample をコピーして、.gitconfig に rename して書き換え。その後ホームディレクトリに置く。

#### .gitconfig

.gitconfig_sample のメールアドレスを変更して、ファイル名を変更してホームディレクトリ配下に置く。

### 2. brew bundle

以下を実行。

```
brew bundle
```

### 3. fish のプラグインをインストール

- fisher をインストール
  - 参考: https://github.com/jorgebucaran/fisher

- プラグインをインストール
  - `dotfiles/fish/fish_plugins` にあるプラグインをインストールする

### iterm2 の shell 統合

ref: [Shell Integration \- Documentation \- iTerm2 \- macOS Terminal Replacement](https://iterm2.com/documentation-shell-integration.html)

```shell
curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash

curl -L https://iterm2.com/shell_integration/zsh \
-o ~/.iterm2_shell_integration.zsh
```

### starship の設定

starship をそのまま使うと、文字化けするため以下を実施。

- 参考: [Starshipでターミナルをカスタマイズしよう\(Mac版\) \- necco note｜necco inc\.](https://necco.inc/note/4809)

### .fzf.zsh

M1 と Intel Mac で fzf がインストールされている場所のパスが異なるため、work と private にそれぞれ .fzf.zshを配置している。
環境構築時はそのパスでシンボリックリンクを作成する。

### vimnium の設定を追加

vimnium で vimium-options.json の設定をインポート

## bin/ 自作スクリプト

[bin配下のスクリプト一覧](./bin/README.md)
