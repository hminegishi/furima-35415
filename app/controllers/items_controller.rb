class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]


  def index
    @items = Item.includes(:user)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image,:item_name,:description,:category_id,:status_id,:charge_id,:sellerprefecture_id,:day_id,:price).merge(user_id: current_user.id)
  end

  #def destroy
  #end

end
