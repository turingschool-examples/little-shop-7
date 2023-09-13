class MerchantsController < ApplicationController

  def show
    @merchants = Merchant.find(params[:id])
  end



end