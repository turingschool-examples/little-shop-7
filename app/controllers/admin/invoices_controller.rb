class Admin::InvoicesController < ApplicationController
  layout "admin/layouts/admin"

  def index
    @invoices = Invoice.all
  end

  def show 
    @invoice = Invoice.find(params[:id])
  end

  def update
    invoice = Invoice.find(params[:id])
    invoice.completed? ? invoice.in_progress! : invoice.completed!

    flash[:notice] = "Invoice status updated."
    redirect_to admin_invoice_path(invoice)
  end
end
