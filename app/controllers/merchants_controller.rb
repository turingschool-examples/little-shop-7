class MerchantsController < ApplicationController
    @merchant = Merchant.find(params[:id])
end