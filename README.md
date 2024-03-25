# README

# ER図
```mermaid
erDiagram
  users ||--o{ items : "1人のユーザーは0以上の出品商品を持つ"
  users ||--o{ purchase_records : "1人のユーザーは0以上の購入記録を持つ"
  items ||--|| shipping_from_preferences : "1つの商品は1つの配送元の設定値を持つ"
  items ||--o| purchase_records : "1つの商品は0か1の購入記録を持つ"
  purchase_records ||--|| shipping_information : "1つの購入記録は1つの発送先情報を持つ"

  users {
    bigint id PK
    string nickname "ニックネーム"
    varchar email "メールアドレス"
    varchar encrypted_password "パスワード"
    string last_name "苗字"
    string first_name "名前"
    string furi_last_name "みょうじ"
    string furi_first_name "なまえ"
    date date_of_birth "生年月日"
    timestamp created_at
    timestamp updated_at
  }

  items {
    bigint id PK
    string item_name "商品名"
    text description "説明"
    integer category "カテゴリ"
    integer condition "状態"
    integer selling_price "販売価格"
    references user FK
    references shippinf_from_preferences FK
    timestamp created_at
    timestamp updated_at
  }

  shipping_from_preferences {
    bigint id PK
    integer shipping_fee_category "配送料負担区分"
    integer shipping_area "発送元地域"
    integer shipping_waiting_time "発送待機日数"
    timestamp created_at
    timestamp updated_at
  }

  purchase_records {
    bigint id PK
    references user FK
    references item FK
    references shipping_information FK
    timestamp created_at
    timestamp updated_at
  }

  shipping_information {
    bigint id PK
    string zip_code "郵便番号"
    string state_province "都道府県"
    string city_town_village "市区町村"
    string street_address "番地"
    string building_name "建物名"
    string phone_number "電話番号"
    timestamp created_at
    timestamp updated_at

  }
```

# テーブル設計

## users（ユーザー情報） テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| nickname           | string  | null: false |
| email              | varchar | null: false, unique: true |
| encrypted_password | varchar | null: false |
| last_name          | string  | null: false |
| first_name         | string  | null: false |
| furi_last_name     | string  | null: false |
| furi_first_name    | string  | null: false |
| date_of_birth      | date    | null: false |

### Association

- has_many :items
- has_many :purchase_records

## items（出品商品情報） テーブル

| Column                    | Type        | Options     |
| ------------------------- | ----------- | ----------- |
| item_name                 | string      | null: false |
| description               | description | null: false |
| category                  | integer     | null: false |
| condition                 | integer     | null: false |
| selling_price             | integer     | null: false |
| user                      | references  | null: false, foreign_key: true |
| shippinf_from_preferences | references  | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase_record
- has_one :shipping_from_preference

## shipping_from_preferences（発送元情報） テーブル

| Column                | Type    | Options     |
| --------------------- | ------- | ----------- |
| shipping_fee_category | integer | null: false |
| shipping_area         | integer | null: false |
| shipping_waiting_time | integer | null: false |

### Association

- belongs_to :item

## purchase_records（購入記録） テーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| user                 | references | null: false, foreign_key: true |
| room                 | references | null: false, foreign_key: true |
| shipping_information | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_information

## shipping_information（発送先情報） テーブル

| Column            | Type   | Options     |
| ----------------- | ------ | ----------- |
| zip_code          | string | null: false |
| state_province    | string | null: false |
| city_town_village | string | null: false |
| street_address    | string | null: false |
| building_name     | string |             |
| phone_number      | string | null: false |

### Association

- belongs_to :shipping_information
