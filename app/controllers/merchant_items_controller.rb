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
    @item = Item.find(params[:id])
    if params[:item_update] == "Update_item"
      @item.update(item_params)
      flash[:alert] = "Update successful"
      redirect_to "/merchants/#{@item.merchant.id}/items/#{@item.id}"
    else params[:commit].present?
      update_enable(@item)
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

  def update_enable(item)
    if params[:commit] == "Enable"
      item.update(enable: true)     
    elsif params[:commit] == "Disable"
      item.update(enable: false)
    end
    redirect_to "/merchants/#{item.merchant.id}/items"
  end
end