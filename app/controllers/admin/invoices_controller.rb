class Admin::InvoicesController < ApplicationController 
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def update
    invoice = Invoice.find(params[:id])
    if params[:status] == "cancelled"
      invoice.update!(status: :cancelled)
    elsif params[:status] == "completed"
      invoice.update!(status: :completed)
    elsif params[:status] == "in progress"
      invoice.update!(status: :in_progress)
    end 
    redirect_to admin_invoice_path(invoice)
  end
 end