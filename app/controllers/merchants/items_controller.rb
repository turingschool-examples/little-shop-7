class Merchants::ItemsController < ApplicationController
  def index
    @merchants = Merchant.find(params[:merchant_id])
  end
end