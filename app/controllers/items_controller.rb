class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  # ストロングパラメータ（画像保存）
  def item_params
    params.require(:item).permit(:item_name,
                                  :description,
                                  :category_id,
                                  :condition_id,
                                  :selling_price,
                                  :shipping_fee_category_id,
                                  :state_province_id,
                                  :shipping_waiting_time_id,
                                  :image).merge(user_id: current_user.id)
  end
  
end
