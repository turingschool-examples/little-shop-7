class Admin::DashboardController < ApplicationController
   def index
      @customers = Customer.all
      @incomplete_invoices = Invoice.incomplete_invoices
   end
end