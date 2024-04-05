class OrderShippingInformation
  include ActiveModel::Model
  attr_accessor :zip_code,
                :state_province_id,
                :city_town_village,
                :street_address,
                :building_name,
                :phone_number,
                :order_id,
                :item_id,
                :user_id
  attr_accessor :token

  # バリデーション
  with_options presence: true do
    # 購入記録
    validates :item_id, :user_id
    # 発送先情報
    validates :zip_code,                          format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-), for example 999-9999.' }
    validates :phone_number,                      format: { with: /\A\d{10,11}\z/, message: 'is invalid. Does not contain a hyphen (-)' }
    validates :state_province_id,                 numericality: { other_than: 1, message: 'is not selected' } 
    validates :city_town_village, :street_address
    validates :token
  end
  # 購入記録
  validate :item_must_be_unique

  def save
    # 購入記録を保存し、変数orderに代入する
    order = Order.create(user_id: user_id, item_id: item_id)
    # 発送先情報を保存する
    # order_idには、変数orderのidと指定する
    ShippingInformation.create(zip_code:           zip_code,
                                state_province_id: state_province_id,
                                city_town_village: city_town_village,
                                street_address:    street_address,
                                building_name:     building_name,
                                phone_number:      phone_number,
                                order_id:          order.id)
  end

  private

  def item_must_be_unique
    if Order.exists?(item_id: item_id)
      errors.add(:base, '商品はすでに売り切れです。')
    end
  end
end