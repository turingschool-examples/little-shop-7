class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:merchant_id])
  end

  def index 
    @merchants = Merchant.all 
  end
end