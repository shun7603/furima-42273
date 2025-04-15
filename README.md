# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birth_date         | date   | null: false |

### Association

- has_many :items
- has_many :orders
- has_many :comments

## items テーブル


| Column             | Type       | Options                     |
| ------------------ | -----------| ----------------------------|
| item_name          | string     | null: false                 |
| description        | text       | null: false                 |
| category_id        | integer    | null: false                 |
| condition_id       | integer    | null: false                 |
| shipping_fee_id    | integer    | null: false                 |
| delivery_time_id   | integer    | null: false                 |
| price              | integer    | null: false                 |
| user_id            | references | null: false,foreign_key:true|

### Association

- has_one :order
- belongs_to :user
- has_many :comments


### ordersテーブル

| Column             | Type       | Options                     |
| ------------------ | -----------| ----------------------------|
| user_id            | references | null: false,foreign_key:true|
| item_id            | references | null: false,foreign_key:true|


### Association

- belongs_to :user
- belongs_to :item
- has_one :address


### addressesテーブル

| Column             | Type       | Options                      |
| ------------------ | -----------| ---------------------------- |
| postal_code        | string     | null: false                  |
| prefecture_id      | integer    | null: false                  |
| city               | string     | null: false                  |
| address            | string     | null: false                  |
| building           | string     |                              |
| phone_number       | string     | null: false                  |
| order_id           | references | null: false,foreign_key:true |


### Association

- belongs_to :order



### commentsテーブル

| Column             | Type       | Options                      |
| ------------------ | -----------| ---------------------------- |
| content            | text       | null: false                  |
| user               | references | null: false,foreign_key:true |
| item               | references | null: false,foreign_key:true |

- belongs_to :user
- belongs_to :item
