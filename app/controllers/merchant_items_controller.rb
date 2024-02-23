class MerchantItemsController < ApplicationController
  def index
    @merch = Merchant.find(params[:merchant_id])
  end

  def show 
    @item = Merchant.find(params[:merchant_id]).items.find(params[:id])
  end
end