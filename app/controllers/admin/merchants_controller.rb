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
    if merchant.update(name:params[:"Merchant Name"])
      redirect_to admin_merchant_path(merchant)
      flash[:success] = "Information has succesfully been updated"
    else 
      redirect_to edit_admin_merchant_path(merchant)
      flash[:failure] = merchant.errors.full_messages.join(' , ')
    end
  end

  private
# the above "update" method needs to be updated to handle this
  def admin_merchants_params
    params.permit(:name)
  end
  
end