class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    if params[:new_name].present?
      @merchant.update(name: params[:new_name])
      redirect_to "/admin/merchants/#{@merchant.id}"
      flash[:alert] = "Update Successful"
    end

    if params[:enable?] == "no"
      @merchant.update(enabled: false)
      redirect_to "/admin/merchants"
    elsif params[:enable?] == "yes"
      @merchant.update(enabled: true)     
      redirect_to "/admin/merchants"
    end
  end
end
