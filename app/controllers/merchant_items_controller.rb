class MerchantItemsController < ApplicationController #named for MerchantsItems because I was getting an error that was looking for MerchantsItems due to the routing. 
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_items = @merchant.items
  end

  def show
    #  require 'pry';binding.pry

    @item = Item.find(params[:item_id])
  end

  
end