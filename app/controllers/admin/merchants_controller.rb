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
    if params[:status] && params[:name]
      merchant.update(merchant_params)
      merchant.save
      flash[:alert] = "Merchant Updated!"
      redirect_to admin_merchant_path(merchant)
    elsif params[:status]
      merchant.update(status: params[:status])
      merchant.save
      redirect_to admin_merchants_path
    end

  end

private
  def merchant_params
    params.permit(:name, :status)
  end
end