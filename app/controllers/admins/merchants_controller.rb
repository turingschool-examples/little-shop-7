class Admins::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end
  def show
    @merchant = Merchant.find(params[:id])
  end
  def edit
    @edit_admins_merchant = Merchant.find(params[:id])
  end
  def update
    @merchant = Merchant.find(params[:id])

    if @merchant.update(merchant_params)
      flash[:notice] = "Merchant information was successfully updated." # Add this line
      redirect_to admins_merchant_path(@merchant)
    else
      render :edit
    end
  end

  def toggle_status
    @merchant = Merchant.find(params[:id])
    @merchant.toggle_status
    redirect_to admins_merchants_path
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name, :status)
  end
end
