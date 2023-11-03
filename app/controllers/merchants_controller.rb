class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
    @items = @merchant.items.joins(:invoices).order('invoices.created_at')
  end
end