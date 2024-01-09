class Admin::InvoicesController < ApplicationController
  layout "admin/layouts/admin"

  def index
    @invoices = Invoice.all
  end

  def show 
    @invoice = Invoice.find(params[:id])
  end

end
