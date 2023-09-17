class MerchantItemsController < ApplicationController #named for MerchantsItems because I was getting an error that was looking for MerchantsItems due to the routing. 
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_items = @merchant.items
  end

  def show
    @item = Item.find(params[:item_id])
  end

  def new
    @item = Item.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @merchant.items.create!(name:params[:item][:name],
     description:params[:item][:description],
      unit_price:params[:item][:price])

      redirect_to "/merchants/#{params[:merchant_id]}/items"
  end
  
end