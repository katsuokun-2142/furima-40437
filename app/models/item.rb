class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee_category
  belongs_to :state_province
  belongs_to :shipping_waiting_time
  has_one_attached :image

  # ActiveHashのバリデーション
  # ActiveHashの選択が「---」の時は保存できないようにする
  validates :category_id,
            :condition,
            :shipping_fee_category,
            :state_province,
            :shipping_waiting_time, numericality: { other_than: 1, message: "can't be blank" } 

  # 画像投稿のバリデーション
  # validates :content, presence: true, unless: :was_attached?
  # or
  # validates :image, presence: true,

  # def was_attached?
  #   self.image.attached?
  # end

end
