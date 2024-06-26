class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to       :category
  belongs_to       :condition
  belongs_to       :shipping_fee_category
  belongs_to       :state_province
  belongs_to       :shipping_waiting_time
  has_one_attached :image
  belongs_to       :user
  has_one          :order

  # ActiveHashのバリデーション
  # ActiveHashの選択が「---」の時は保存できないようにする
  validates :category_id,
            :condition_id,
            :shipping_fee_category_id,
            :state_province_id,
            :shipping_waiting_time_id, numericality: { other_than: 1, message: "is not selected" }

  validates :image, :item_name, :description, presence: true
  INTETGER_REGEX = /\A\d+\z/.freeze
  with_options presence: true, format: { with: INTETGER_REGEX } do
    validates :selling_price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                              presence: { message: "can't be blank" }
  end
end
