class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items.all
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.find(params[:id])
    if item.update(item_params)
      flash[:alert] = "Merchant information updated successfully!"
      redirect_to merchant_item_path(merchant, item)
    else
      redirect_to  edit_merchant_item_path(merchant, item)
      flash[:alert] = "Error: #{error_message(item.errors)}"
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price) 
  end
end