class Merchants::ItemsController < ApplicationController
  
  def show
    @item = Item.find(params[:items_id])
  end 

  def edit
    @item = Item.find(params[:item_id])
  end
  
  def update
    @item = Item.find(params[:item_id])
    if @item.update(item_params)
      flash[:notice] = "Item information was successfully updated."
      redirect_to "/merchants/#{@item.merchant.id}/items/#{@item.id}"
    else
      render :edit
    end
  end



  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end

  def item_status
    @item = Item.find(params[:item_id])
    @item.update_status
    redirect_to "/merchants/#{params[:merchant_id]}/items"
  end
end

