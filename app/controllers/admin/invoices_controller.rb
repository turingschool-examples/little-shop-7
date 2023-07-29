class Admin::InvoicesController < ApplicationController
  def show
    
  end

  def index
    @invoices = Invoice.all
  end
end
