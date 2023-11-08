class Admin::InvoicesController < ApplicationController
  def index
    if params[:order] == "alphabetical"
      @invoices = Invoice.sort_alphabetical
    elsif params[:order] == "date"
      @invoices = Invoice.sort_by_date
    else
      @invoices = Invoice.all
    end
  end

  def show
    @invoice = Invoice.find(params[:invoice_id])
  end
  
  def update
    @invoice = Invoice.find(params[:id])
    if params[:status_update] == "Completed"
      @invoice.update(status: "completed")
    elsif params[:status_update] == "In Progress"
      @invoice.update(status: "in progress")
    else params[:status_update] == "Cancelled"
      @invoice.update(status: "cancelled")
    end
    return redirect_to admin_invoices_path if params[:page] == "index"
    redirect_to admin_invoice_show_path(@invoice) if params[:page] == "show"
  end
end