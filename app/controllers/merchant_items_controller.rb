class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end
  
  def show
    @item = Item.find(params[:item_id])
  end

  def edit
    @item = Item.find(params[:item_id])
  end

  def update
    @item = Item.find(params[:item_id])
    if params[:item_update] == "Update_item"
      @item.update(item_params)
      flash[:alert] = "Update successful"
      redirect_to "/merchants/#{@item.merchant.id}/items/#{@item.id}"
    end
    if params[:commit] == "Enable"
      @item.update(enable: true)     
      redirect_to "/merchants/#{@item.merchant.id}/items"
    elsif params[:commit] == "Disable"
      @item.update(enable: false)
      redirect_to "/merchants/#{@item.merchant.id}/items"
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.create(item_params)
    redirect_to "/merchants/#{@merchant.id}/items"
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end
end