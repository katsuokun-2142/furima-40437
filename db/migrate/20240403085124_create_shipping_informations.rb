class CreateShippingInformations < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_informations do |t|
      t.string     :zip_code, null: false,                  comment: '郵便番号'
      t.integer    :state_province_id, null: false,         comment: '都道府県-ActiveHash'
      t.string     :city_town_village, null: false,         comment: '市区町村'
      t.string     :street_address, null: false,            comment: '番地'
      t.string     :building_name,                          comment: '建物名'
      t.string     :phone_number, null: false,              comment: '電話番号'
      t.references :order, null: false, foreign_key: true,  comment: '購入記録'
      t.timestamps
    end
  end
end
