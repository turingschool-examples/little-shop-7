class Admin::MerchantsController < ApplicationController
    def index
        @merchants = Merchant.all
        @top_merchants = Merchant.top_merchants
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

        merchant.update(merchant_params)

        if merchant_params[:name]
            flash[:notice] = "Merchant information is updated successfully"
            redirect_to admin_merchant_path(merchant)
        end

        if merchant_params[:status]
            flash[:notice] = "Merchant status is updated successfully"
            redirect_to admin_merchants_path
        end
    end

    private

    def merchant_params
        params.require(:merchant).permit(:name, :status)
    end
end
