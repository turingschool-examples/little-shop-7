class Admins::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end
  def show
    @merchant = Merchant.find(params[:id])
  end
  def edit
    @edit_admins_merchant = Merchant.find(params[:id])
  end
end
