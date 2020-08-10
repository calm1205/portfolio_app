# 設計方針
- 最初はXXを期限としてポートフォリオの完成をアジャイル開発で目指す。
- Gitでお互いにコードレビューはしない。勝手にマージ。コンフリクト起きたら会話。
- 本番環境はいきなり作らない。まずはローカルでの開発をメインとする。
- 一週間に一回15分程度でSPRを行う。来週までの目標や自分の取れる工数の確認。
- 作ってみたい機能があれば自由にカードに追加可能。


# Portfolio DB設計

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, add_index: true|
|email|string|null: false|
### Association
- has_one :address
- has_one :card
- has_many :orders

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_reading|string|null: false|
|first_name_reading|string|null: false|
|postal_code|string|null: false|
|prefecture_id|integer|null: false|
|city|string|null: false|
|building|string|null: false|
|phone_number|string|null: false|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user

## productsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|detail|string|null: false|
|category_id|integer|null: false, foreign_key: true|
|price|integer|null: false|
### Association
- belongs_to :category
- has_many :orders

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|src|text|null: false|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|
### Association
- has_many :users

## cardsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|string|null: false, foreign_key: true|
|card_token|string|null: false|
|customer_token|string|null: false|
### Association
- belongs_to :user

## ordersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|string|null: false, foreign_key: true|
|product_id|string|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :product

## Prefecture(ActiveHash)
|Column|Type|Options|
|------|----|-------|
|prefecture|string|null: false|
### Association
- has_many: products