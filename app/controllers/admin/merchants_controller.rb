class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    if params[:new_name].present?
      @merchant.update(name: params[:new_name])
      redirect_to "/admin/merchants/#{@merchant.id}"
      flash[:name_changed] = "You have successfully changed the company's name."
    end
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
  end
end
