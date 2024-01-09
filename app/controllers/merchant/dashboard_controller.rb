class Merchant::DashboardController < ApplicationController 
  layout 'merchant/layouts/dashboard'

  def index 
    @merchant = Merchant.find(params[:merchant_id])
  end
end