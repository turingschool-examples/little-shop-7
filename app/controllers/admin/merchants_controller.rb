class Admin::MerchantsController < ApplicationController
    def index
        @merchants = Merchant.all
    end

    def show
        @merchant = Merchant.find(params[:id])
    end

    def create
        merchant = Merchant.new(merchant_params)
        if merchant.save
            redirect_to "/admin/merchants/index"
        else
            redirect_to "admin/merchants/new"
            flash[:alert] = "Error. Please enter a name."
        end
    end

    private

    def merchant_params
        params.permit(:name)
    end
end