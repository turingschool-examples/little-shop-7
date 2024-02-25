class ItemsController < ApplicationController

  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
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
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])

    if @item.update(item_params)
      redirect_to merchant_item_path(@merchant, @item)
      flash[:alert] = "Item information successfully updated!!"
      # else 
      #   flash[:alert] = "Item information NOT successfully updated"
    end 
    
  end

  private 

  def item_params
    params.permit(:name, :description, :unit_price)
  end

end