class ItemsController < ApplicationController 
    def show 
      @item = Item.find(params[:item_id])
    end

    def edit
      @item = Item.find(params[:item_id])
    end

    def update
      item = Item.find(params[:item_id])
      item.update(name: params[:name], description: params[:description], unit_price: params[:unit_price])
      redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}"
      flash[:notice] = "Update successful!"
    end

    private

    def merchant_params
        params.permit(:id)
    end
end