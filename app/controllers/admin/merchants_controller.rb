class Admin::MerchantsController < ApplicationController

  def index
    @enabled_merchants = Merchant.enabled_merchants
    @disabled_merchants = Merchant.disabled_merchants
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    merchant.save
    flash[:alert] = "Merchant Updated!"

    redirect_to admin_merchant_path(merchant)
  end

private
  def merchant_params
    params.require(:merchant).permit(:name)
  end
end