class Merchants::ItemsController < ApplicationController
  
  def show
    @item = Item.find(params[:items_id])
  end 

  def edit
    @item = Item.find(params[:item_id])
  end

  def update
    @item = Item.find(params[:item_id])
    # if @item.update(item_params)
    #   flash[:notice] = "Merchant information was successfully updated." # Add this line
    #   redirect_to merchants_item_path(@item)
    # else
    #   render :edit
    # end
  end
end

