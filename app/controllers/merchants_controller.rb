class MerchantsController < ApplicationController
  def create
    @merchant = Merchant.create!(merchant_params)
  end

  def invoices
    @merchant = Merchant.find(params[:id])
    @item_ids = Item.where(merchant_id: @merchant.id).pluck(:id)
    @invoice_items = InvoiceItem.where(item_id: @item_ids)
  end

  private

  def merchant_params
    params.permit(:id, :name, :created_at, :updated_at)
  end
end