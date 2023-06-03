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
    @merchant = Merchant.find(params[:id])
    if @merchant.update(merchant_params)
      redirect_to "/admin/merchants/#{@merchant.id}"
      flash[:notice] = "Merchant #{@merchant.id} has been successfully updated"
    else
      redirect_to "/admin/merchants/#{@merchant.id}/edit"
    end
  end

  private
  def merchant_params
    params.require(:merchant).permit(:name)
  end
end