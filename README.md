# テーブル設計

## users テーブル

| Column             | Type        | Options                  |
| ------------------ | ----------- | ------------------------ |
| nickname           | string      | null: false              |
| email              | string      | unique:true, null: false |
| encrypted_password | string      | null: false              |
| family_name        | string      | null: false              |
| first_name         | string      | null: false              |
| family_name_kana   | string      | null: false              |
| first_name_kana    | string      | null: false              |
| birthday           | date        | null: false              |

### Association

- has_many :items
- has_many :buyers

## items テーブル

| Column               | Type        | Options                        |
| -------------------- | ----------- | ------------------------------ |
| item_name            | string      | null: false                    |
| description          | text        | null: false                    |
| category_id          | integer     | null: false                    |
| status_id            | integer     | null: false                    |
| charge_id            | integer     | null: false                    |
| sellerprefecture_id  | integer     | null: false                    |
| day_id               | integer     | null: false                    |
| price                | integer     | null: false                    |
| user                 | references  | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one    :buyer

## buyers テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| item      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one    :shipping

## shippings テーブル

| Column           | Type        | Options                        |
| ---------------- | ----------- | ------------------------------ |
| postal_code      | string      | null: false                    |
| prefecture_id    | integer     | null: false                    |
| city             | string      | null: false                    |
| address          | string      | null: false                    |
| building_name    | string      |                                |
| phone            | string      | null: false                    |
| buyer            | references  | null: false, foreign_key: true |

### Association

- belongs_to :buyer