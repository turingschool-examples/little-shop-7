class MerchantsController < ApplicationController

  def show
    @merchants = Merchant.find(params[:merchant_id])
  end



end