class MerchantsController < ApplicationController

  def show
    @merchant = Merchant.find(params[:id])
    @top_customers = @merchant.top_customers
    @transactions = @merchant.transactions
    @not_shipped = @merchant.not_yet_shipped_ascending
  end

end
