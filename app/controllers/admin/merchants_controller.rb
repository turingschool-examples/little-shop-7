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
    merchant = Merchant.find(params[:id])

    if merchant.update({name: params[:name]})

      merchant.save
      redirect_to admin_merchant_path(merchant.id)
      flash[:alert] = "Merchant Successfully Updated"
    else
      redirect_to admin_merchant_path(merchant.id)
      flash[:alert] = "Merchant Unsuccessfully Updated"
    end
  end

  # if pet.update(pet_params)
  #   redirect_to "/pets/#{pet.id}"
  # else
  #   redirect_to "/pets/#{pet.id}/edit"
  #   flash[:alert] = "Error: #{error_message(pet.errors)}"
  # end
end
