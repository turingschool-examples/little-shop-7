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

    if merchant.update(admin_merchants_params)
      redirect_to admin_merchant_path(merchant)
      flash[:success] = "Information has succesfully been updated"
    else 
      redirect_to edit_admin_merchant_path(merchant)
      flash[:failure] = merchant.errors.full_messages.join(' , ')
    end
  end

  private

  def admin_merchants_params
    params.require(:merchant).permit(:name, :status)
  end
  
end