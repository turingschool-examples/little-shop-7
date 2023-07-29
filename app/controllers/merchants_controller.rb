class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
  end

  def index 
    require 'pry'; binding.pry
    @merchant_items = self.item_list
  end
end