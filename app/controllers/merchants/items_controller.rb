class Merchants::ItemsController < ApplicationController
  
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @item = Item.find(params[:id])
  end 

  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    if item_params[:status].present? == false
      @item.update_status
    end
    
    if @item.update(item_params)
      flash[:notice] = "Item information was successfully updated."
      redirect_to "/merchants/#{@item.merchant.id}/items/#{@item.id}"
    else
      redirect_to "/merchants/#{@item.merchant.id}/items"
    end
  end
  # def item_status
  #   @item = Item.find(params[:item_id])
  #   @item.update_status
  #   redirect_to “/merchants/#{params[:merchant_id]}/items”
  # end
  private
  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end
end

