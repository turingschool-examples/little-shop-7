class Admin::MerchantsController < ApplicationController
  before_action :set_merchant, only: [:update]
  
  def index
    @merchants = Merchant.all
    @enabled_merchants = Merchant.enabled_merchants
    @disabled_merchants = Merchant.disabled_merchants
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
      if !params[:merchant][:status].nil?
        redirect_to admin_merchants_path
      else 
        redirect_to admin_merchant_path(@merchant)
        flash[:success] = 'Merchant information updated successfully.'
      end
    else
      redirect_to edit_admin_merchant_path(@merchant)
      flash[:alert] = "Error: #{error_message(@merchant.errors)}"
    end
  end

  def new 
    @merchant = Merchant.new
  end

  def create 
    @merchant = Merchant.new(merchant_params)
    if @merchant.save
      flash[:success] = "Merchant created successfully."
      redirect_to admin_merchants_path
    else 
      flash[:error] = "Error: #{error_message(@merchant.errors)}"
      redirect_to new_admin_merchant_path
    end
  end
  
  private

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end

  def merchant_params
    params.require(:merchant).permit(:name, :status) 
  end
end
