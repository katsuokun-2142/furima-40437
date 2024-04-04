class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order_shipping_information = OrderShippingInformation.new
  end

  def create
    binding.pry
    @order_shipping_information = OrderShippingInformation.new(order_shipping_information_params)
    if @order_shipping_information.valid?
      @order_shipping_information.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
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
