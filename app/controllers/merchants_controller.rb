class MerchantsController < ApplicationController


  def show 
    @merchant = Merchant.find(params[:id])
  end

  def dashboard
    show
  end
end