require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '出品ができるとき' do
      it 'すべての値が正しく入力されている場合は出品ができる' do
        expect(@item).to be_valid
      end
    end

    context '出品ができないとき' do
      it 'imageが空の場合は出品ができない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'nameが空の場合は出品ができない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it 'nameが41文字超える場合は出品ができない' do
        @item.name = 'あ' * 41
        @item.valid?
        expect(@item.errors.full_messages).to include('Name is too long (maximum is 40 characters)')
      end

      it 'introduceが空の場合は出品ができない' do
        @item.introduce = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Introduce can't be blank")
      end

      it 'introduceが1001文字超える場合は出品ができない' do
        @item.introduce = 'あ' * 1001
        @item.valid?
        expect(@item.errors.full_messages).to include('Introduce is too long (maximum is 1000 characters)')
      end

      it 'categoryを選択していない場合は出品ができない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category Select')
      end

      it 'stateを選択していない場合は出品ができない' do
        @item.state_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('State Select')
      end

      it 'postageを選択していない場合は出品ができない' do
        @item.postage_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Postage Select')
      end

      it 'prefectureを選択していない場合は出品ができない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture Select')
      end

      it 'shipping_dateを選択していない場合は出品ができない' do
        @item.shipping_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping date Select')
      end

      it 'priceが空の場合は出品ができない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが全角数字の場合は出品ができない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range or Half-width number')
      end

      it 'priceが300円未満の場合は出品ができない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range or Half-width number')
      end

      it 'priceが9,999,999円超える場合は出品ができない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price Out of setting range or Half-width number')
      end
    end
  end
end
