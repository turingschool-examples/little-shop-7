class Merchants::InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:format])
  end

  def show

  end
end