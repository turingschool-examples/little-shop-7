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

    if params[:status].present?
      merchant.update(admin_merchant_params)
      merchant.save
      redirect_to admin_merchants_path
    else
      merchant.update(admin_merchant_params)
      if merchant.save
        redirect_to admin_merchant_path(merchant.id)
        flash[:success] = "The information has been successfully updated for #{merchant.name}"
      end
    end
  end

  private
  def admin_merchant_params
    params.permit(:name, :status)
  end
end