class Admin::MerchantsController < ApplicationController
   def index
      @merchants = Merchant.all
   end

   def show
      @merchant = Merchant.find(params[:id])
   end

   def edit
      @merchant = Merchant.find(params[:id])
   end

   def update
      @merchant = Merchant.find(params[:id])
      if @merchant.update(merchant_params)
         redirect_to admin_merchant_path(@merchant.id)
         flash[:alert] = "Merchant Successfully Updated"
      else
         flash[:alert] = "Error: #{error_message(@merchant.errors)}"
         redirect_to edit_admin_merchant_path(@merchant.id)
      end
   end


   private
   def merchant_params
      params.require(:merchant).permit(:name)
   end
end