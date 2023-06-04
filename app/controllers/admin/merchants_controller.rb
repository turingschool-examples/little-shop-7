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

  def create
    merchant = Merchant.create(merchant_params)
    redirect_to "/admin/merchants/#{merchant.id}"
  end

  def update
    merchant = Merchant.find(params[:id])
    if merchant.update(merchant_params)
      redirect_to "/admin/merchants/#{merchant.id}"
      flash[:alert] = "Sucessfully edited merchant"
    else
      redirect_to "/admin/merchants/#{merchant.id}/edit"
    end
  end

  private
  def merchant_params
    params.permit(:name)
  end
end