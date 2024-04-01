class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_item, only: [:show, :edit, :update]

  def index
    @items = Item.includes(:user).order('created_at DESC')
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

  def show
  end

  def edit
    return if current_user.id == @item.user.id

    redirect_to action: :index
    # unless current_user.id == @item.user.id
    #     redirect_to action: :index
    # end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(params[:id])
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      redirect_to items_path
    else
      render :show, status: :unprocessable_entity
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

  # itemの読み出し
  def load_item
    @item = Item.find(params[:id])
  end
end
