# bin

## コマンド一覧
- bookscan_downloader
- gems_info

## gems_info

Rails のプロジェクトルート配下で実行されることを想定。
プロジェクトルートのGemfileに記載されているGemのサマリーとホームページのURLを標準出力に出す。

```shell
❯ gems_info.rb
Name: rails
Summary: Full-stack web application framework.
URL: https://rubyonrails.org
```

## notion_postman

Notionに日報ページをPOSTするスクリプト

```shell
NOTION_DATABASE_ID=*** NOTION_API_TOKEN=*** bin/notion_postman.rb
```
