class Admins::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @top_merchants = Merchant.top_5_by_revenue
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
      flash[:notice] = "Merchant information was successfully updated."
      redirect_to admin_merchant_path(@merchant)
    else
      render :edit
    end
  end

  def toggle_status
    @merchant = Merchant.find(params[:id])
    @merchant.toggle_status
    redirect_to admin_merchants_path
  end
  
  def new
    
  end

  def create
    @merchant = Merchant.new(name: params[:name], status: params[:status])

    if @merchant.save
      flash[:notice] = "Merchant information was successfully created."
      redirect_to admin_merchants_path
    else
      render :new
    end
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name, :status)
  end
end