class MerchantItemsController < ApplicationController
  def index
    @merch = Merchant.find(params[:merchant_id])
  end
end