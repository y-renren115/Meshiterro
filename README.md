# 新人研修 4回目(meshiterro)
## 始めに
- **当研修課題についての質問はNGです。ご了承お願いします。**

## 研修内容について
- このアプリケーションは、meshiterroにいくつかのエラーを仕込んだものです。
  - 下に示されている計8個のエラーが起こりますので、
    - どういうエラーか
    - どこに解決の糸口が書いてあるのか
    - どこを修正すれば良いのか
  - を説明できるよう、実際に動かしてしっかり確認して下さい。
- 加えて、以下の内容を説明できるようにしておいてください。
  - アソシエーションとは ...
    - 必要な手順(カラム追加&モデルに記述)
    - @user.post_images, @post_image.userの意味
    - `〇〇_id`が空の状態で保存しようとするとどうなるか ...標準出力にrollback toransactioが表示されて,データが正しく保存されない。
  - refileの使用法
    - カラムの追加&モデルに記述
    - refileの基本的な仕様
	- いいね機能
	  - いいねの作成と削除
	  - すでにいいねしているかどうかの判定(favorited_by?メソッド)
	- routing
	  - resourcesとresourceの違い
	  - ネストについて
	- パラメーター
	  - ターミナルのどこにparameterが出力されているか
	  - paramsメソッドとは(何を受け取ることができるか)
	  - ストロングパラメーターで受け取れる値について

## ローカル環境のセットアップとログイン
- `Gemfile` に指定された Ruby と Bundler を用意し、`bundle install` を実行してください。
- `bin/rails db:setup` で空の開発用データベースを作成し、新規登録画面で自分のテストアカウントを作成してください。共有アカウントや既存データベースは配布しません。
- 研修に必要な投稿・コメント・いいねはローカル環境で作成してください。以下のエラー一覧にあるIDは例です。自分で作成した投稿のIDを使用してください。
- `.env.example` は設定項目の見本です。このアプリは `.env` を自動読込しません。
- 開発・テストの署名鍵は Rails がローカルの `tmp/development_secret.txt` に生成します。本番は実行環境の秘密情報管理機能で `SECRET_KEY_BASE` を設定してください。
- Refile の署名鍵は Rails の非公開の鍵から用途別に導出します。独立した鍵を使う場合は、十分にランダムな64文字以上の `REFILE_SECRET_KEY` を設定してください。空の値は指定しないでください。
- 署名鍵の変更後は古い画像URLが無効になるため、画面を再読込し、保存済みURLやキャッシュも更新してください。
- `.env`、秘密鍵、データベース、バックアップや実在の個人情報をコミットしないでください。
- ソースの変更は既存アカウント・鍵や Git の過去履歴を変更しません。既存環境の確認・更新は別途必要です。

## 設定のテスト
`ruby test/security/secrets_configuration_test.rb` と `ruby test/security/refile_configuration_test.rb` は Rails を起動せずに実行できます。

## エラー
### ルートパス(ログイン後)
NoMethodError ×3
1. undefined method 'user'
2. undefined method 'profile_image'
3. undefined method 'user_path'

### /post_images/4 ※詳細ページならどれでも可
4. ArgumentError
5. いいね作成時にActiveRecord::RecordNotFound
6. コメント投稿ができない (rollback transaction)
