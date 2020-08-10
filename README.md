# Portfolio DB設計

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, add_index: true|
|email|string|null: false|
### Association
- has_one :address

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