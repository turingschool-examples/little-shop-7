class Admin::MerchantsController < ApplicationController
    def index
        @merchants = Merchant.all
    end

    def show
        @merchant = Merchant.find(params[:id])
    end

    def new
    end

    def create
        @merchant = Merchant.new(merchant_params)
        if @merchant.save
            redirect_to admin_merchants_path
        else
            flash[:alert] = "Error. Please enter a name."
            render :new
        end
    end

    private

    def merchant_params
        params.permit(:id, :name)
    end
end