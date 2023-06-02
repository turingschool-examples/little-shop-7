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
      if params[:commit] == "Submit"
        flash[:success] = "#{@merchant.name} was successfully updated"
        redirect_to admin_merchant_path(@merchant)
      else
        flash[:error] = "Merchant must have a name"
        render :edit
        # redirect_to edit_admin_merchant_path(@merchant_2)
      end
    end
  end


  private
  def merchant_params
    params.require(:merchant).permit(:name)
  end
end