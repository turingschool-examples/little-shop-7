class Merchant::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if( params.has_key?(:name) && params.has_key?(:description) && params.has_key?(:unit_price) ) 
      item.update(name: params[:name], description: params[:description], unit_price: params[:unit_price])
      redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}"
      flash[:notice] = "Update successful!"
    elsif( params.has_key?(:status) )
      if item.status == "Enabled"
        item.update(status: "Disabled")
      else
        item.update(status: "Enabled")
      end
      redirect_to "/merchants/#{item.merchant_id}/items"
    end
  end
end
