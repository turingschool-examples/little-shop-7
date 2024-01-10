class Merchant::ItemsController < ApplicationController 
    def index 
      @merchant = Merchant.find(params[:merchant_id])
      @items = @merchant.items
    end

    def show 
      @item = Item.find(params[:id])
      @merchant = @item.merchant
    end
    
end