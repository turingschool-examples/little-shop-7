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

    if params.key?(:name)
      if merchant.update({name: params[:name]})
        merchant.save
        redirect_to admin_merchant_path(merchant.id)
        flash[:alert] = "Merchant Successfully Updated"
      else
        redirect_to admin_merchant_path(merchant.id)
        flash[:alert] = "Merchant Unsuccessfully Updated"
      end
    end

    if params.key?(:enabled) 
      if merchant.update({enabled: params[:enabled]})
        merchant.save
        redirect_to admin_merchants_path
        flash[:alert] = "Merchant Successfully Updated"
      else
        flash[:alert] = "Merchant Unsuccessfully Updated"
      end
    end
  end

  def merchant_params
    params.permit(:enabled, :name)
  end
end
