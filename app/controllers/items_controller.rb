class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:item_id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @item = Item.create!(item_params)
  end

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def edit
    @item = Item.find(params[:item_id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    item = Item.find(params[:item_id])
    merchant = Merchant.find(params[:merchant_id])
    if item.update(item_params)
      item.update(status: params[:status]) if params[:status].present?
      redirect_to "/merchants/#{item.merchant_id}/items"
      flash[:alert] = "Update Successful"
    else
      redirect_to "/merchants/#{merchant.id}/items/#{item.id}/edit"
      flash[:alert] = "Error: Update Unsuccessful"
    end
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end