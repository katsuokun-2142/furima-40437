class OrderShippingInformation
  include ActiveModel::Model
  attr_accessor :zip_code, :state_province_id, :city_town_village, :street_address, :building_name, :phone_number, :order_id, :item_id, :user_id

  # バリデーション
  with_options presence: true do
  end

  def save
    # 購入記録を保存し、変数orderに代入する
    order = Order.create(user_id: user_id, item_id: item_id)
    # 発送先情報を保存する
    # order_idには、変数orderのidと指定する
    ShippingInformation.create(zip_code: zip_code,
                                state_province_id: state_province_id,
                                city_town_village: city_town_village,
                                street_address: street_address,
                                building_name: building_name,
                                phone_number: phone_number,
                                order_id: order.id)
  end
end