class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:merchant_id])
    # @invoice = Invoice.find(params[:merchant_id])
    # @item = Item.find(params[:merchant_id])
  end
end