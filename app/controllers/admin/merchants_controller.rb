class Admin::MerchantsController < ApplicationController

  def index
    @enabled_merchants = Merchant.enabled_merchants
    @disabled_merchants = Merchant.disabled_merchants
    @top_5_merchants = Merchant.top_5_merchants_by_revenue
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def new
    @merchant = Merchant.new
  end

  def create
    merchant = Merchant.new(merchant_params)
    merchant.save
    redirect_to admin_merchants_path
  end


  def update
    merchant = Merchant.find(params[:id])    
    if params[:status]
      merchant.update(status: params[:status])
      merchant.save
      redirect_to admin_merchants_path
    else 
      merchant.update(merchant_params)
      merchant.save
      flash[:alert] = "Merchant Updated!"
      redirect_to admin_merchant_path(merchant)
    end
  end

private
  def merchant_params
    params.require(:merchant).permit(:name)
  end
end