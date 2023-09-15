class ItemsController < ApplicationController
  def edit
    # @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
    @name = params[:name]
    @description = params[:description]
    @unit_price = params[:unit_price]
  end

  def update
    
    item = Item.find(params[:item_id])

    item.update(item_params)
    # require 'pry';binding.pry
    redirect_to "/merchants/#{params[:merchant_id]}/items"
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price)
  end
  
end