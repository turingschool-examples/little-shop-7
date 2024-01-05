class MerchantItemsController < ApplicationController
    def index
        @merchant = Merchant.find(params[:merchant_id])
    end

    private

    def merchant_params
        params.permit(:id)
    end
end
