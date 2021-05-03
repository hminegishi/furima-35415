class BuyersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @item = Item.find(params[:item_id])
    @buyer_shipping = BuyerShipping.new
    redirect_to root_path if @item.buyer.present?
  end

  def create
    @item = Item.find(params[:item_id])
    @buyer_shipping = BuyerShipping.new(buyer_params)
    if @buyer_shipping.valid?
      pay_item
      @buyer_shipping.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def buyer_params
    params.require(:buyer_shipping).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # "sk_test_c9dd24e7da670fc488f85ea4"
    Payjp::Charge.create(
      amount: @item.price,
      card: buyer_params[:token],
      currency: 'jpy'
    )
  end
end
