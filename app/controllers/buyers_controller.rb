class BuyersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    @buyer_shipping = BuyerShipping.new
    redirect_to root_path if @item.buyer.present? || @item.user_id == current_user.id
  end

  def create
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

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: buyer_params[:token],
      currency: 'jpy'
    )
  end
end
