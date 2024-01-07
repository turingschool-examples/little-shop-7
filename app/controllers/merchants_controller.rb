class MerchantsController < ApplicationController
  def create
    @merchant = Merchant.create!(merchant_params)
  end

  private

  def merchant_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end