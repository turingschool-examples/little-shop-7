class Admin::InvoicesController < ApplicationController
  def show
    @invoice = Invoice.find(params[:id])
    @invoice_items = @invoice.invoice_items
  end

  def index
    @invoices = Invoice.all
  end

  def index
    @invoices = Invoice.all
  end
end
