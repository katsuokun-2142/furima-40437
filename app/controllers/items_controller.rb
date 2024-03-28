class ItemsController < ApplicationController
  before_action :basic_auth
  before_action :authenticate_user!, except: [:index]

  def index
  end

  def new
    @item = Item.new
  end

  def create
    item = Item.create(item_params)
    if item.save

    else

    end
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]  # 環境変数を読み込む記述に変更
    end
  end

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
                                  :image)
                                  .merge(user_id: current_user.id)
  end
  
end
