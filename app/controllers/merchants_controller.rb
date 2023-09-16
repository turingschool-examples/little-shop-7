class MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
  end
  def show
    @merchants = Merchant.find(params[:merchant_id])
    @top_5 = @merchants.customers.order_customers_by_transactions
  end



end