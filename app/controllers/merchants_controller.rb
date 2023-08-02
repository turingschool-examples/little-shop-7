class MerchantsController < ApplicationController
  
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end
  def show
    @random = PhotoService.new.random
    @merchant = Merchant.find(params[:id])
  end
end