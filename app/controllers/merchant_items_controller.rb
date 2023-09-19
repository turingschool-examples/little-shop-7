class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:item_id])
  end

  def update
    item = Item.find(params[:item_id])

    item.update(status: (params[:status] == "enable" ? 1 : 0))
    item.save

    redirect_to "/merchants/#{params[:merchant_id]}/items"
  end
end