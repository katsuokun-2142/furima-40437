require 'rails_helper'

RSpec.describe OrderShippingInformation, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_shipping_information = FactoryBot.build(:order_shipping_information, user_id: user.id, item_id: item.id)
  end

  describe '購入記録と発送先情報の保存' do
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_shipping_information).to be_valid
        sleep 0.5 # DBの処理に時間がかかるため、時間を置きます。
      end
      it '建物名(building_name)は空でも保存できること' do
        @order_shipping_information.building_name = ''
        expect(@order_shipping_information).to be_valid
        sleep 0.5
      end
      it '電話番号が10桁の場合、保存できること' do
        @order_shipping_information.phone_number = '1234567890'
        expect(@order_shipping_information).to be_valid
        sleep 0.5
      end
      it '電話番号が11桁の場合、保存できること' do
        @order_shipping_information.phone_number = '12345678901'
        expect(@order_shipping_information).to be_valid
        sleep 0.5
      end
    end

    context '内容に問題がある場合' do
      it 'トークンが空の場合、保存できないこと' do
        @order_shipping_information.token = nil
        @order_shipping_information.valid?
        expect(@order_shipping_information.errors.full_messages).to include("Token can't be blank")
        sleep 0.5
      end
      it '商品が売り切れの場合、保存できないこと' do
        another_user = FactoryBot.create(:user)
        another_order_shipping_information = FactoryBot.build(:order_shipping_information, user_id: another_user.id, item_id: @order_shipping_information.item_id)
        @order_shipping_information.save
        another_order_shipping_information.valid?
        expect(another_order_shipping_information.errors.full_messages).to include('商品はすでに売り切れです。')
        sleep 0.5
      end
      it '購入者がいない場合、保存できないこと' do
        @order_shipping_information.user_id = nil
        @order_shipping_information.valid?
        expect(@order_shipping_information.errors.full_messages).to include("User can't be blank")
        sleep 0.5
      end
      it '購入品がない場合、保存できないこと' do
        @order_shipping_information.item_id = nil
        @order_shipping_information.valid?
        expect(@order_shipping_information.errors.full_messages).to include("Item can't be blank")
        sleep 0.5
      end
      it '郵便番号が空だの場合、保存できないこと' do
        @order_shipping_information.zip_code = nil
        @order_shipping_information.valid?
        expect(@order_shipping_information.errors.full_messages).to include("Zip code can't be blank")
        sleep 0.5
      end
      it '郵便番号が8桁の数字の場合、保存できないこと' do
        @order_shipping_information.zip_code = '12345678'
        @order_shipping_information.valid?
        expect(@order_shipping_information.errors.full_messages).to include('Zip code is invalid. Include hyphen(-), for example 999-9999.')
        sleep 0.5
      end
      it '郵便番号が「4桁ハイフン3桁」の半角文字列の場合、保存できないこと' do
        @order_shipping_information.zip_code = '1234-567'
        @order_shipping_information.valid?
        expect(@order_shipping_information.errors.full_messages).to include('Zip code is invalid. Include hyphen(-), for example 999-9999.')
        sleep 0.5
      end
      it '郵便番号が全角文字列の場合、保存できないこと' do
        @order_shipping_information.zip_code = 'おはよう'
        @order_shipping_information.valid?
        expect(@order_shipping_information.errors.full_messages).to include('Zip code is invalid. Include hyphen(-), for example 999-9999.')
        sleep 0.5
     end
      it '都道府県を選択していない場合、保存できないこと' do
        @order_shipping_information.state_province_id = 1
        @order_shipping_information.valid?
        expect(@order_shipping_information.errors.full_messages).to include("State province is not selected")
        sleep 0.5
      end
      it '都道府県の値がない場合、保存できないこと' do
        @order_shipping_information.state_province_id = nil
        @order_shipping_information.valid?
        expect(@order_shipping_information.errors.full_messages).to include("State province can't be blank")
        sleep 0.5
      end
      it '市区町村が空の場合、保存できないこと' do
        @order_shipping_information.city_town_village = nil
        @order_shipping_information.valid?
        expect(@order_shipping_information.errors.full_messages).to include("City town village can't be blank")
        sleep 0.5
      end
      it '番地が空の場合、保存できないこと' do
        @order_shipping_information.street_address = nil
        @order_shipping_information.valid?
        expect(@order_shipping_information.errors.full_messages).to include("Street address can't be blank")
        sleep 0.5
      end
      it '電話番号が空の場合、保存できないこと' do
        @order_shipping_information.phone_number = nil
        @order_shipping_information.valid?
        expect(@order_shipping_information.errors.full_messages).to include("Phone number can't be blank")
        sleep 0.5
      end
      it '電話番号が9桁の場合、保存できないこと' do
        @order_shipping_information.phone_number = '123456789'
        @order_shipping_information.valid?
        expect(@order_shipping_information.errors.full_messages).to include("Phone number is invalid. Does not contain a hyphen (-)")
        sleep 0.5
      end
      it '電話番号が12桁の場合、保存できないこと' do
        @order_shipping_information.phone_number = '123456789012'
        @order_shipping_information.valid?
        expect(@order_shipping_information.errors.full_messages).to include('Phone number is invalid. Does not contain a hyphen (-)')
        sleep 0.5
      end
      it '電話番号が全角数値の場合、保存できないこと' do
        @order_shipping_information.phone_number = 'こんにちは'
        @order_shipping_information.valid?
        expect(@order_shipping_information.errors.full_messages).to include('Phone number is invalid. Does not contain a hyphen (-)')
        sleep 0.5
      end
    end
  end
end
