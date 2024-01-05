class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.enabled? ? merchant.disabled! : merchant.enabled!
    
    redirect_to admin_merchants_path
  end
end
