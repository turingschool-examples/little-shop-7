class Admin::DashboardController < ApplicationController
    def index
        @top_customers = Invoice.top_customers
        @invoices = InvoiceItem.incomplete_invoices
      

    end
  end