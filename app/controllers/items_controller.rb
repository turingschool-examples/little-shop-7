class ItemsController < ApplicationController 
    def show 
      @item = Item.find(params[:item_id])
    end

    private

    def merchant_params
        params.permit(:id)
    end
end