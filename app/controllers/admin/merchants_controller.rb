class Admin::MerchantsController < ApplicationController
    def index
        @merchants = Merchant.all
    end

    def show
        @merchant = Merchant.find(params[:id])
    end

    def new
        @merchant = Merchant.new
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

    def edit
        @merchant = Merchant.find(params[:id])
    end

    def update
        merchant = Merchant.find(params[:id])
        if merchant.update(merchant_params)
            flash[:notice] = "Merchant information is updated successfully"
            redirect_to admin_merchant_path(merchant)

        end
    end

    private

    def merchant_params
        params.require(:merchant).permit(:name)
    end
end
