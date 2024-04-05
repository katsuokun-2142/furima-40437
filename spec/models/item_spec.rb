require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '出品商品の新規登録' do
    context '新規登録できる場合' do
      it '必要な情報を適切に入力して登録できる' do
        expect(@item).to be_valid
      end
    end
    context '新規登録できない場合' do
      it '画像が空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が空では登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it '商品説明が空では登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'カテゴリが「---」では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category is not selected')
      end
      it 'カテゴリが空では登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Category is not selected')
      end
      it '商品状態が「---」では登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition is not selected')
      end
      it '商品状態が空では登録できない' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition is not selected')
      end
      it '配送料の負担の情報が「---」では登録できない' do
        @item.shipping_fee_category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping fee category is not selected')
      end
      it '配送料の負担の情報が空では登録できない' do
        @item.shipping_fee_category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping fee category is not selected')
      end
      it '発送元の地域の情報が「---」では登録できない' do
        @item.state_province_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('State province is not selected')
      end
      it '発送元の地域の情報が空では登録できない' do
        @item.state_province_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('State province is not selected')
      end
      it '発送までの日数の情報が「---」では登録できない' do
        @item.shipping_waiting_time_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping waiting time is not selected')
      end
      it '発送までの日数の情報が空では登録できない' do
        @item.shipping_waiting_time_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping waiting time is not selected')
      end
      it '価格が空では登録できない' do
        @item.selling_price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Selling price can't be blank")
      end
      it '価格が300より小さい場合、登録できない' do
        @item.selling_price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price must be greater than or equal to 300')
      end
      it '価格が9999999より大きい場合、登録できない' do
        @item.selling_price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price must be less than or equal to 9999999')
      end
      it '価格に全角が含まれているの場合、登録できない' do
        @item.selling_price = '全角'
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price is not a number')
      end
      it '価格に半角英字が含まれているの場合、登録できない' do
        @item.selling_price = 'test'
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price is not a number')
      end
      it '価格が少数の場合、登録できない' do
        @item.selling_price = 300.5
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price must be an integer')
      end
      it 'Userテーブルと紐づいていない場合、登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
