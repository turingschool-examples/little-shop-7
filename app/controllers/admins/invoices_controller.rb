class Admins::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end
  def show
    @invoice = Invoice.find(params[:id])
  end
end