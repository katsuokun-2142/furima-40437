class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true,  comment: '購入者'
      t.references :item, null: false, foreign_key: true,  comment: '購入品'
      t.timestamps
    end
  end
end
