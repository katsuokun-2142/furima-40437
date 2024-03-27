require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "必要な情報を適切に入力して登録できる" do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it "ニックネームが空では登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "メールアドレスが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "メールアドレスがすでに登録されている場合、登録できない" do
        ather_user = FactoryBot.create(:user)
        @user.email = ather_user.email
        @user.valid?
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end
      it "メールアドレスが@を含んでいない場合、登録できない" do
        @user.email = @user.email.gsub('@','')
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "パスワードが空では登録できない" do
        @user.password = ''
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "パスワードが6文字より少ない場合、登録できない" do
        @user.password = @user.password.slice(0,5)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "パスワードは、半角英字のみの場合、登録できない" do
        @user.password = 'abcdef'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end
      it "パスワードは、半角数字のみの場合、登録できない" do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end
      it "パスワードは、全角文字の場合、登録できない" do
        @user.password = 'あいうえおＴＸＴ'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end
      it "パスワードとパスワード（確認）の値の一致しない場合、登録できない" do
        @user.password = @user.password+'a'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "お名前(全角)が名字が空の場合、登録できない" do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字と名前が必要です")
      end
      it "お名前(全角)が名前が空の場合、登録できない" do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字と名前が必要です")
      end
      it "お名前(全角)が全角（漢字・ひらがな・カタカナ）での入力がされていない場合、登録できない" do
        @user.last_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(全角)には全角（漢字・ひらがな・カタカナ）で設定してください")
      end
      it "お名前カナ(全角)が名字が空の場合、登録できない" do
        @user.furi_last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字と名前のふりがなが必要です")
      end
      it "お名前カナ(全角)が名前が空の場合、登録できない" do
        @user.furi_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字と名前のふりがなが必要です")
      end
      it "お名前カナ(全角)が全角（カタカナ）での入力がされていない場合、登録できない" do
        @user.furi_first_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(全角)には全角（カタカナ）で設定してください")
      end
      it "生年月日が空では登録できない" do
        @user.date_of_birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Date of birth can't be blank")
      end
    end
  end
end
