class ItemsController < ApplicationController 
    def show 
      @item = Item.find(params[:item_id])
    end

    def edit
      @item = Item.find(params[:item_id])
    end

    def update
      item = Item.find(params[:item_id])
      if params[:name].length > 0 && params[:description].length > 0 && params[:unit_price].length > 0
        item.update(name: params[:name], description: params[:description], unit_price: params[:unit_price])
        flash[:notice] = "Update successful!"
      else
        flash[:notice] = "Update failed."
      end
      redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}"
    end

    private

    def merchant_params
        params.permit(:id)
    end
end