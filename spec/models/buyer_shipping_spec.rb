require 'rails_helper'
RSpec.describe BuyerShipping, type: :model do
  describe '購入情報の保存' do
    before do
      @user = FactoryBot.create(:user)
      @buyer_shipping = FactoryBot.build(:buyer_shipping, user_id: @user.id)
    end
  
    context '購入できる場合' do
      it 'ログイン状態の出品者以外のユーザーのみ、必要な情報を適切に入力すると、商品の購入ができること' do
        expect(@buyer_shipping).to be_valid
      end
    end

    context '購入できない場合' do
      it 'postal_codeが空だと保存できないこと' do
        @buyer_shipping.postal_code = ''
        @buyer_shipping.valid?
        expect(@buyer_shipping.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @buyer_shipping.postal_code = '1234567'
        @buyer_shipping.valid?
        expect(@buyer_shipping.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'prefecture_idを選択していないと保存できないこと' do
        @buyer_shipping.prefecture_id = 0
        @buyer_shipping.valid?
        expect(@buyer_shipping.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと保存できないこと' do
        @buyer_shipping.city = ''
        @buyer_shipping.valid?
        expect(@buyer_shipping.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが空だと保存できないこと' do
        @buyer_shipping.address = ''
        @buyer_shipping.valid?
        expect(@buyer_shipping.errors.full_messages).to include("Address can't be blank")
      end
      it 'building_nameは空でも保存できること' do
        @buyer_shipping.building_name = ''
        expect(@buyer_shipping).to be_valid
      end
      #it 'priceが空だと保存できないこと' do
       # @buyer_shipping.price = nil
       # @buyer_shipping.valid?
       # expect(@buyer_shipping.errors.full_messages).to include("Price can't be blank")
      #end
      #it 'priceが全角数字だと保存できないこと' do
       # @buyer_shipping.price = ２０００
       # @buyer_shipping.valid?
       # expect(@buyer_shipping.errors.full_messages).to include("Price can't be blank")
      #end
      #it 'priceが1円未満では保存できないこと' do
       # @buyer_shipping.price = 0
       # @buyer_shipping.valid?
       # expect(@buyer_shipping.errors.full_messages).to include("Price can't be blank")
      #end
      it 'userが紐付いていないと保存できないこと' do
        @buyer_shipping.user_id = nil
        @buyer_shipping.valid?
        expect(@buyer_shipping.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @buyer_shipping.item_id = nil
        @buyer_shipping.valid?
        expect(@buyer_shipping.errors.full_messages).to include("Item can't be blank")
      end
      it '電話番号は11桁以内の数値のみ保存可能なこと（09012345678となる）' do
        @buyer_shipping.phone = '090123456789'
        @buyer_shipping.valid?
        expect(@buyer_shipping.errors.full_messages).to include("Phone numbers with in 11 digits")
      end
    end
  end
end
#bundle exec rspec spec/models/buyer_shipping_spec.rb
