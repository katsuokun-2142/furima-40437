# README

# ER図
```mermaid
erDiagram
  users ||--o{ items : "1人のユーザーは0以上の出品商品を持つ"
  users ||--o{ orders : "1人のユーザーは0以上の購入記録を持つ"
  items ||--o| orders : "1つの商品は0か1の購入記録を持つ"
  orders ||--|| shipping_informations : "1つの購入記録は1つの発送先情報を持つ"

  users {
    bigint id PK
    string nickname           "ニックネーム"
    string email              "メールアドレス"
    string encrypted_password "パスワード"
    string last_name          "苗字"
    string first_name         "名前"
    string furi_last_name     "みょうじ"
    string furi_first_name    "なまえ"
    date date_of_birth        "生年月日"
    timestamp created_at
    timestamp updated_at
  }

  items {
    bigint id PK
    string item_name                 "商品名"
    text description                 "説明"
    integer category_id              "カテゴリ-ActiveHash"
    integer condition_id             "状態-ActiveHash"
    integer selling_price            "販売価格"
    integer shipping_fee_category_id "配送料負担区分-ActiveHash"
    integer state_province_id        "発送元地域-ActiveHash"
    integer shipping_waiting_time_id "発送待機日数-ActiveHash"
    references user FK               "ユーザー"
    timestamp created_at
    timestamp updated_at
  }

  orders {
    bigint id PK
    references user FK "購入者"
    references item FK "購入品"
    timestamp created_at
    timestamp updated_at
  }

  shipping_informations {
    bigint id PK
    string zip_code           "郵便番号"
    integer state_province_id "都道府県-ActiveHash"
    string city_town_village  "市区町村"
    string street_address     "番地"
    string building_name      "建物名"
    string phone_number       "電話番号"
    references order          "購入記録"
    timestamp created_at
    timestamp updated_at
  }
```

# テーブル設計

## users（ユーザー情報） テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| nickname           | string  | null: false |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false |
| last_name          | string  | null: false |
| first_name         | string  | null: false |
| furi_last_name     | string  | null: false |
| furi_first_name    | string  | null: false |
| date_of_birth      | date    | null: false |

### Association

- has_many :items
- has_many :orders

## items（出品商品情報） テーブル

| Column                   | Type       | Options     |
| ------------------------ | ---------- | ----------- |
| item_name                | string     | null: false |
| description              | text       | null: false |
| category_id              | integer    | null: false |
| condition_id             | integer    | null: false |
| selling_price            | integer    | null: false |
| shipping_fee_category_id | integer    | null: false |
| state_province_id        | integer    | null: false |
| shipping_waiting_time_id | integer    | null: false |
| user                     | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order

## orders（購入記録） テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_information

## shipping_informations（発送先情報） テーブル

| Column            | Type       | Options     |
| ----------------- | ---------- | ----------- |
| zip_code          | string     | null: false |
| state_province_id | integer    | null: false |
| city_town_village | string     | null: false |
| street_address    | string     | null: false |
| building_name     | string     |             |
| phone_number      | string     | null: false |
| order             | references | null: false, foreign_key: true |

### Association

- belongs_to :order
