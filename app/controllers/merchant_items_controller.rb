class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    @top_earning_items = @merchant.top_earning_items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.new(item_params)
    item.update(status: 1)
    if item.save
      redirect_to "/merchants/#{merchant.id}/items"
      flash[:alert] = "Item created successfully"
    else
      redirect_to "/merchants/#{merchant.id}/items/new"
      flash[:alert] = "Item not created successfully"
    end
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
    item.update(item_params)
    if params[:commit].starts_with?("Update")
      redirect_to "/merchants/#{merchant.id}/items/#{item.id}"
      flash[:alert] = "Information has been successfully updated"
    elsif params[:item][:enabled]
      item.update(status: 0)
      redirect_to "/merchants/#{merchant.id}/items"
    else params[:item][:disabled]
      item.update(status: 1)
      redirect_to "/merchants/#{merchant.id}/items"
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :status)
  end
end
