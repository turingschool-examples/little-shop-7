class Admin::MerchantsController < ApplicationController 
  def index 
    @merchants= Merchant.all
  end

  def show 
    @merchant = Merchant.find(params[:id])
  end

  def edit 
    @merchant = Merchant.find(params[:id])
  end
  
  def update
    merchant = Merchant.find(params[:id])
    merchant.update(name: params[:"Merchant Name"])
    redirect_to admin_merchant_path(merchant)
    flash[:success]="Information has succesfully been updated"
  end
end