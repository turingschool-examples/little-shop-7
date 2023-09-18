class MerchantItemsController < ApplicationController #named for MerchantsItems because I was getting an error that was looking for MerchantsItems due to the routing. 
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_items = @merchant.items
  end

  def show
    @item = Item.find(params[:item_id])
  end

  def update 
    # require 'pry';binding.pry
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.find(params[:item_id])

    item.update(status: params[:status])
    redirect_to "/merchants/#{params[:merchant_id]}/items"
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price)
  end
  
end