class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    if Item.exists?(id: params[:item_id], user_id: current_user.id)
      redirect_to root_path and return
    end
    if Order.exists?(item_id: params[:item_id])
      redirect_to root_path and return
    end
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @item = Item.find(params[:item_id])
    @order_shipping_information = OrderShippingInformation.new
  end

  def create
    @order_shipping_information = OrderShippingInformation.new(order_shipping_information_params)
    if @order_shipping_information.valid?
      pay_item
      # 購入記録と発送先情報の登録
      @order_shipping_information.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      @item = Item.find(params[:item_id])
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
                                                        :phone_number).merge(user_id: current_user.id,
                                                                              item_id: params[:item_id],
                                                                              token: params[:token])
  end

  def pay_item
    # クレジットカード機能
    target_item = Item.find(params[:item_id]) # 商品情報取得
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount:   target_item.selling_price,                  # 商品の値段
      card:     order_shipping_information_params[:token],  # カードトークン
      currency: 'jpy'                                       # 通貨の種類（日本円）
    )
  end
end
