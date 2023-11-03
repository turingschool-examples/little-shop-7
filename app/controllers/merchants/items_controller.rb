class Merchants::ItemsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to merchant_item_path(merchant, item)
    else
      render :edit
      flash[:alert] = "Error: #{error_message(item.errors)}"
    end
  end
  
  private
  
  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
  