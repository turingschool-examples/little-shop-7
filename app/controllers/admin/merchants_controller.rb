class Admin::MerchantsController < ApplicationController 
  
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  
  def edit 
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
   
    if params[:update_status] == "disable"
      merchant.update!(status: :disabled)
      redirect_to admin_merchants_path
    elsif params[:update_status] == "enable"
      merchant.update!(status: :enabled)
      redirect_to admin_merchants_path
    else
      merchant.update!(name: params[:name])
      redirect_to admin_merchant_path(merchant)
      flash[:notice] = 'Update Successful'
    end
  end
end