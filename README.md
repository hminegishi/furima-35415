# テーブル設計

## users テーブル

| Column           | Type        | Options     |
| ---------------- | ----------- | ----------- |
| nickname         | string      | null: false |
| email            | string      | null: false |
| password         | string      | null: false |
| family_name      | string      | null: false |
| first_name       | string      | null: false |
| family_name_kana | string      | null: false |
| first_name_kana  | string      | null: false |
| birthday         | Active_Hash | null: false |

### Association

- has_many :items
- has_many :buyers

## items テーブル

| Column            | Type        | Options                        |
| ----------------- | ----------- | ------------------------------ |
| item_name         | text        | null: false                    |
| description       | text        | null: false                    |
| category          | Active_Hash | null: false                    |
| status            | Active_Hash | null: false                    |
| charge            | Active_Hash | null: false                    |
| seller_prefecture | Active_Hash | null: false                    |
| days              | Active_Hash | null: false                    |
| price             | string      | null: false                    |
| user              | references  | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one    :buyer

## buyers テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| item      | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- has_one    :shipping

## shippings テーブル

| Column        | Type        | Options                        |
| ------------- | ----------- | ------------------------------ |
| postal_code   | string      | null: false                    |
| prefecture    | Active_Hash | null: false                    |
| city          | string      | null: false                    |
| address       | string      | null: false                    |
| building_name | string      |                                |
| phone         | string      |                                |
| user          | references  | null: false, foreign_key: true |
| item          | references  | null: false, foreign_key: true |

### Association

- belongs_to :buyer