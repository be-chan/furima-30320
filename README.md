#テーブル設計

## users テーブル 
| Column             | Type   | Option                 |
|--------------------|--------|------------------------|
| nickname           | string | NOT NULL               |
| email              | string | NOT NULL, unique: true |
| encrypted_password | string | NOT NULL               |
| last_name          | string | NOT NULL               |
| first_name         | string | NOT NULL               |
| last_name_kana     | string | NOT NULL               |
| first_name_kana    | string | NOT NULL               |
| birthday           | date   | NOT NULL               |

### Association
- has_many :items
- has_many :purchase_recodes

## items テーブル
| Column             | Type       | Option              |
|--------------------|------------|---------------------|
| name               | string     | NOT NULL            |
| introduce          | text       | NOT NULL            |
| category_id        | integer    | NOT NULL            |
| state_id           | integer    | NOT NULL            |
| postage_id         | integer    | NOT NULL            |
| prefecture_id      | integer    | NOT NULL            |
| shipping_date_id   | integer    | NOT NULL            |
| price              | integer    | NOT NULL            |
| user               | references | foreign_key: true   |

### Association
- belongs_to :user
- has_one :purchase_recode

## purchase_recodes テーブル
| Column | Type       | Option            |
|--------|------------|-------------------|
| user   | references | foreign_key: true |
| item  | references | foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :address

## address テーブル
| Column          | Type       | Option            |
|-----------------|------------|-------------------|
| postal_code     | string     | NOT NULL          |
| prefecture_id   | integer    | NOT NULL          |
| city            | string     | NOT NULL          |
| address         | string     | NOT NULL          |
| building_name   | string     |                   |
| phone_number    | string     | NOT NULL          |
| purchase_recode | references | foreign_key: true |

### Association
- belongs_to :purchase_recode
