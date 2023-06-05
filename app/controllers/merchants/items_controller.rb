class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
  end

  def show
    @item = Item.find(params[:id])
    @merchant = Merchant.find(@item.merchant_id)
  end

  def edit
    @item = Item.find(params[:id])
    @merchant = Merchant.find(@item.merchant_id)
  end

  def update
    item = Item.find(params[:id])
    if params[:status] == "0"
      item.update(status: 0)
      redirect_to "/merchants/#{item.merchant_id}/items"
    elsif params[:status] == "1"
      item.update(status: 1)
      redirect_to "/merchants/#{item.merchant_id}/items"
    else
      item.update(item_params)
      redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}"
      flash[:notice] = "Item #{item.name} Successfully Updated!"
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :status)
  end
end