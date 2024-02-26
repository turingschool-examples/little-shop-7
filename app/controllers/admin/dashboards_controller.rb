class Admin::DashboardsController < ApplicationController
    include Admin::DashboardsHelper
    def index
        @top_customers = Customer.top_customers
        @incomplete_invoices = Invoice.incomplete_invoices
    end
end