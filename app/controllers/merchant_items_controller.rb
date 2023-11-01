class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    @items = @merchant.items
  end

  def show
    @item = Item.find(params[:item_id])
    @merchant = @item.merchant
  end

  def edit
    @item = Item.find(params[:id])
    @merchant = @item.merchant
  end

  def update
    @item = Item.find(params[:id])
    @merchant = @item.merchant
  end
end