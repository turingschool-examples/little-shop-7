class InvoicesController < ApplicationController
  def create
    @invoice = Invoice.create!(invoice_params)
  end

  def show # created for us-15
    @invoice = Invoice.find(params[:id])
  end

  private

  def invoice_params
    params.permit(:id, :customer_id, :status, :created_at, :updated_at)
  end
end