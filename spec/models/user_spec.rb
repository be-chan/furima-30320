require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくできるとき' do
      it 'nicknameとemail, password, password_confirm, last_name,first_name, last_name_kana, first_name_kana, birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end

      it 'passwordが6文字以上,半角英数字混合で登録できる' do
        @user.password = '00000a'
        @user.password_confirmation = '00000a'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくできないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'emailが一意性がない場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailに@が含まれていない場合は登録できない' do
        @user.email = 'test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが5文字以下の時は登録ができない' do
        @user.password = '0000a'
        @user.password_confirmation = '0000a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが半角英数字混合でないと登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid', 'Password confirmation is invalid')
      end

      it 'passwordが入力されていても、password_confirmが入力されていないと登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'passwordとpassword_confirmationが一致していないと登録できない' do
        @user.password = '111111a'
        @user.password_confirmation = '222222a'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'last_nameとfirst_nameが空の場合は登録できない' do
        @user.last_name = ''
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", 'Last name is invalid', "First name can't be blank", 'First name is invalid')
      end

      it 'last_nameとfirst_nameが全角(漢字、ひらがな、カタカナ)ではない場合は登録できない' do
        @user.last_name = 'yamada'
        @user.first_name = 'Taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid', 'First name is invalid')
      end

      it 'last_name_kanaとfirst_name_kanaが空だと登録できない' do
        @user.last_name_kana = ''
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank", 'Last name kana is invalid', "First name kana can't be blank", 'First name kana is invalid')
      end

      it 'last_name_kanaとfirst_name_kanaが全角(カタカナ)ではない場合は登録できない' do
        @user.last_name_kana = '山田'
        @user.first_name_kana = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid', 'First name kana is invalid')
      end

      it 'birthdayが空だと登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
