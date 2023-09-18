class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
  end
  
  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(
      name: params[:name],
      description: params[:description],
      unit_price: params[:unit_price],
      merchant_id: params[:merchant_id]
    )
    item.save

    redirect_to "/items/#{item.id}"
  end
end