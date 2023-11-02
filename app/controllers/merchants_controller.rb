class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @top_customers = @merchant.top_five_customers
  end
end