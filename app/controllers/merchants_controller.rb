class MerchantsController < ApplicationController
  
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end
  def show
    @merchant = Merchant.find(params[:id])
  end
end