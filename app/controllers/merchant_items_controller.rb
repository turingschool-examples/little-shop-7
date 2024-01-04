class MerchantItemsController < ApplicationController
    def index
        @merchant = Merchant.find(params[:merchant_id])
        #@merchant_items = @merchant.items
    end

    private

    def merchant_params
        params.permit(:id)
    end
end