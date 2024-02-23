class MerchantItemsController < ApplicationController
  def index
    @merch = Merchant.find(params[:merchant_id])
  end

  def show 
    @item = Merchant.find(params[:merchant_id]).items.find(params[:id])

  end

  def edit
    @merch = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @item = Merchant.find(params[:merchant_id]).items.find(params[:id])
    Item.update(strong_params)
    flash[:alert] = "Update successful"
    redirect_to merchant_item_path(params[:merchant_id], params[:id])
  end

  private 
  def strong_params
    params.permit(:name, :description, :unit_price)
  end
end