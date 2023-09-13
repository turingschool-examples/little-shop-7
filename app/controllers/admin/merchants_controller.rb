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
    if merchant.update(merchant_params)
      flash[:notice] = "Merchant name has been updated"
      redirect_to "/admin/merchants/#{merchant.id}"
    else
      flash[:alert] = "Error: #{error_message(merchant.errors)}"
      redirect_to "/admin/merchants/#{merchant.id}/edit"
    end
  end

  private

  def merchant_params
    params.permit(:name)
  end
end