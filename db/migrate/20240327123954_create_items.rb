class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string      :item_name, null: false,                 comment: '商品名'
      t.text        :description, null: false,               comment: '説明'
      t.integer     :category_id, null: false,               comment: 'カテゴリ-ActiveHash'
      t.integer     :condition_id, null: false,              comment: '状態-ActiveHash'
      t.integer     :selling_price, null: false,             comment: '販売価格'
      t.integer     :shipping_fee_category_id, null: false,  comment: '配送料負担区分-ActiveHash'
      t.integer     :state_province_id, null: false,         comment: '発送元地域-ActiveHash'
      t.integer     :shipping_waiting_time_id, null: false,  comment: '発送待機日数-ActiveHash'
      t.references	 :user, null: false, foreign_key: true,  comment: '出品者'
      t.timestamps
    end
  end
end
