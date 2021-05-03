class BuyersController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @item = Item.find(params[:item_id])
    @buyer_shipping = BuyerShipping.new
  end

  def create
    @item = Item.find(params[:item_id])
    @buyer_shipping = BuyerShipping.new(buyer_params)
    if @buyer_shipping.valid?
      @buyer_shipping.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def buyer_params
    params.require(:buyer_shipping).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
