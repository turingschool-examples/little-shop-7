class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
  end

  def merchant_customer
    require 'pry'; binding.pry
    items[0].invoices[0].customer
  end
end