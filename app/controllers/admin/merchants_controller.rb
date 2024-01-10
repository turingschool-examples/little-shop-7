class Admin::MerchantsController < ApplicationController
  layout 'admin/layouts/admin'

  def index
    @merchants = Merchant.all
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.enabled? ? merchant.disabled! : merchant.enabled!

    redirect_to admin_merchants_path
  end

  def new
    @merchant = Merchant.new
  end

  def create
    merchant = Merchant.create(merchant_params)

    redirect_to admin_merchants_path
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
