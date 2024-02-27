class Admin::ItemInvoiceController < ApplicationController
    def show
        invoice_item = InvoiceItem.find(params[:id])
    end
end