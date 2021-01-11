require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '商品購入情報の保存' do
    before do
      @purchase_address = FactoryBot.build(:purchase_address)
    end
    context '商品購入ができるとき' do
      it '全ての値が正しく入力されていれば保存できる' do
        expect(@purchase_address).to be_valid
      end

      it 'building_nameが空でも登録ができる' do
        @purchase_address.building_name = ''
        expect(@purchase_address).to be_valid
      end
    end

    context '商品購入ができないとき' do
      it 'user_idが空の場合は登録できない' do
        @purchase_address.user_id = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空の場合は登録できない' do
        @purchase_address.item_id = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
      end

      it 'tokenが空の場合は登録できない' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'postal_codeが空の場合は登録できない' do
        @purchase_address.postal_code = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Postal code can't be blank", 'Postal code is invalid. Include hyphen(-)')
      end

      it 'postal_codeにハイフンがないと登録できない' do
        @purchase_address.postal_code = '1234567'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it 'prefectureを選択していない場合は登録できない' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Prefecture Select')
      end

      it 'cityが空の場合は登録できない' do
        @purchase_address.city = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("City can't be blank")
      end

      it 'addressが空の場合は登録できない' do
        @purchase_address.address = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Address can't be blank")
      end

      it 'phone_numberが空の場合は登録できない' do
        @purchase_address.phone_number = ''
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank", 'Phone number number is invalid. Include half-width numbers')
      end

      it 'phone_numberにハイフンがあると登録できない' do
        @purchase_address.phone_number = '080-0800-0800'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number number is invalid. Include half-width numbers')
      end

      it 'phone_numberが11桁以内ではない場合は登録できない' do
        @purchase_address.phone_number = '090000000001'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include('Phone number within 11 digits')
      end
    end
  end
end
