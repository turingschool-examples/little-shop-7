class MerchantItemsController < ApplicationController
  def index
    @items = Merchant.find(params[:merchant_id]).items
  end

  def show 
    @item = Item.find(params[:id])
  end

  def edit
    @merch = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    if params[:status]
     redirect_to merchant_items_path(params[:merchant_id])
    else
      flash[:alert] = "Update successful"
      redirect_to merchant_item_path(params[:merchant_id], params[:id])
    end
  end

  def new
    @merch = Merchant.find(params[:merchant_id])
  end

  def create
    @merch = Merchant.find(params[:merchant_id])
    @merch.items.create(item_params)
    redirect_to merchant_items_path(params[:merchant_id])
  end

  private 
  
  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end
end