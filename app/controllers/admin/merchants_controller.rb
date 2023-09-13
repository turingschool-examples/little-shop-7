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
      flash[:success] = "Merchant information updated successfully."
      redirect_to admin_merchant_path(@merchant)
    else
      render :edit
    end
  end

  def disable_enable
    @merchant = Merchant.find(params[:id])
    @merchant.toggle_disabled
    @merchant.save
    notice = @merchant.disabled ? "Merchant #{@merchant.name} disabled." : "Merchant #{@merchant.name} enabled."
    redirect_to '/admin/merchants', notice: notice
  end

  private 

  def merchant_params
    params.require(:merchant).permit(:name)
  end
end