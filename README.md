# Volun-Tuner
<https://volun-tuner.net>

## 概要
　　Volun-Tunerは、ボランティア活動を簡単に主催、参加ができるアプリケーションです。

## 機能
- 参加
- フォロー
- いいね
- コメント
- タグ
- ランキング
  1. いいね数
  1. 参加人数
  1. 参加数(ユーザー)
  1. 主催数(ユーザー)
- 検索
  1. フリーワードで
  1. 現在地から(スマホ・タブレットのみ)
  1. タグから
  1. 都道府県から
  1. カレンダーから
- 地図表示
- 現在地取得
- スケジュール
- 通知
- 画像プレビュー
  
#### 技術面での工夫
- 未ログインユーザーはいいね、参加、コメントを非表示に
- フォロワーの主催ボランティアをタイムラインとして表示
- 終了したボランティアは参加ボタン、リストから非表示に
- 非同期通信を用いたフォロー、いいね、コメントボタンの実装
- 非同期通信を用いたページネーション・カレンダーの実装
- 参加するボランティアをマイページのカレンダーに表示
- カレンダーの内容をモーダル、ツールチップを用いて表示
- 各ランキングをタブメニューを用いて切替
- レスポンシブ対応
- 現在地から検索ボタンをタブレットサイズ未満のみ表示
- GoogleMapsAPIを用いた集合場所の表示
- スライドメニューを用いたお知らせ機能の表示
- 未確認の通知がある時はアイコンを表示
- jQueryを用いたボランティア主催確認画面の実装

## 使用言語

- ruby 2.5.7
- Rails 5.2.4.2
- javascript/jQuery
  
## 使用技術
### 開発環境

- Vagrant + VirtualBox


### インフラ
- AWS(EC2, RDS, Route53)
- MySQL2
- Nginx(Webサーバ)

###  Gem・APIなど
- Rspec (モデルテスト、コントローラテスト、フィーチャーテスト)
- devise (認証機能)
- dotenv-rails (環境変数管理)
- I18n (日本語化)
- GoogleMapAPI (地図表示)
- Geolocation API (現在地取得機能)
- Geocoder (現在地取得機能)
- simple calendar (スケジュール機能)
- carrierwave (画像投稿)
- acts-as-taggable-on (タグ機能)
- kaminari (ページネーション)
- bootstrap4
- font-awesome
- Rubocop

## インストール　
```
$ git clone https://github.com/nkwada/Volun-Tuner.git
$ cd Volun-Tuner
$ bundle install
$ rails db:migrate
$ rails db:seed
```
