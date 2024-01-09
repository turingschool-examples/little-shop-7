class Admin::MerchantsController < ApplicationController 
  
  def index
    @merchants = Merchant.all
    @top_5_merch = Merchant.top_five_merchants
    # require 'pry'; binding.pry
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  
  def edit 
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
   
    if params[:update_status] == "disable"
      merchant.update!(status: :disabled)
      redirect_to admin_merchants_path
    elsif params[:update_status] == "enable"
      merchant.update!(status: :enabled)
      redirect_to admin_merchants_path
    else
      merchant.update!(name: params[:name])
      redirect_to admin_merchant_path(merchant)
      flash[:notice] = 'Update Successful'
    end
  end

  def create 
    merchant = Merchant.new(merchant_params)
    if merchant.save 
      redirect_to admin_merchants_path
    else 
      flash[:error] = "Error: All fields must be filled in to submit"
      redirect_to new_admin_merchant_path
    end
  end

  private
  def merchant_params
    params.permit(:name, :id, :status)
  end
end