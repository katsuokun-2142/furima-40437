class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order_shipping_information = OrderShippingInformation.new# Formオブジェクトを追加
  end

  def create
    binding.pry
  end

  private

  def order_shipping_information_params
    params.require(:order_shipping_information).permit(:zip_code,
                                                        :state_province_id,
                                                        :city_town_village,
                                                        :street_address,
                                                        :building_name,
                                                        :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
