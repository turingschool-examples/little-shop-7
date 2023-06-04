class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
  end

  def show
    @item = Item.find(params[:id])
    @merchant = Merchant.find(@item.merchant_id)
  end

  def edit
    @item = Item.find(params[:id])
    @merchant = Merchant.find(@item.merchant_id)
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}"
    flash[:notice] = "Item #{item.name} Successfully Updated!"
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end
end