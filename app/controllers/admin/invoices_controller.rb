class Admin::InvoicesController < ApplicationController

  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    if @invoice.update(admin_invoice_params)
      redirect_to admin_invoice_path(@invoice)
      flash[:success] = "Information has succesfully been updated"
    else
      render :edit
      # flash[:failure] = invoice.errors.full_messages.join(' , ')
    end
  end

  private

  def admin_invoice_params
    params.require(:invoice).permit(:status)
  end
end
