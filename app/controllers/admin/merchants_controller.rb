class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchants.all
  end

  def show
    @merchant.find(params[:id])
  end
end