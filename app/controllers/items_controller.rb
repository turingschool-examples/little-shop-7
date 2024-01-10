class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:item_id])
  end

  def create
    @item = Item.create!(item_params)
  end

  # def show
  #   @item = Item.find(params[:id])
  # end

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    @item = Item.find(params[:item_id])
    @item.update(status: params[:status]) if params[:status].present?
    redirect_to "/merchants/#{@item.merchant_id}/items"
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end
end