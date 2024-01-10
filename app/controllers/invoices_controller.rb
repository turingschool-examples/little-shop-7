class InvoicesController < ApplicationController
  def create
    @invoice = Invoice.create!(invoice_params)
  end

  def show
    @invoice = Invoice.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
    @invoice_items = InvoiceItem.where(item_id: @merchant.item_ids)
  end

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoice_items = InvoiceItem.where(item_id: @merchant.item_ids)
  end

  private

  def invoice_params
    params.permit(:id, :customer_id, :status, :created_at, :updated_at)
  end
end