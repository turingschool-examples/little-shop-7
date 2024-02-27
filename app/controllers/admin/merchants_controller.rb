class Admin::MerchantsController < ApplicationController
    def index
        @merchants = Merchant.all
    end

    def show
        @merchant = Merchant.find(params[:id])
    end

<<<<<<< HEAD
    def new
    end

    def create
        @merchant = Merchant.new(merchant_params)
        if @merchant.save
            redirect_to admin_merchants_path
        else
            flash[:alert] = "Error. Please enter a name."
            render :new
=======
    def edit
        @merchant = Merchant.find(params[:id])
    end

    def update
        merchant = Merchant.find(params[:id])
        if merchant.update(merchant_params)
            flash[:notice] = "Merchant information is updated successfully"
            redirect_to admin_merchant_path(merchant)
>>>>>>> 0320c0772db02ddf7eb9fe92beb3088e2c4c3688
        end
    end

    private

    def merchant_params
<<<<<<< HEAD
        params.permit(:id, :name)
    end
end
=======
        params.require(:merchant).permit(:name)
    end
end
>>>>>>> 0320c0772db02ddf7eb9fe92beb3088e2c4c3688
