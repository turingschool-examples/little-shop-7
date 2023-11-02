class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @top_customers = Customer.top_five_customers(@merchant)
  end
end