class Merchants::ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
  end

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    
  end
end