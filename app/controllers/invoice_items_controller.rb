class InvoiceItemsController < ApplicationController
  def index
    @invoice_items = InvoiceItem.all
  end

  def new
  end
end