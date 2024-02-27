class Admin::InvoicesController < ApplicationController
    include Admin::DashboardsHelper
    def index 
        @invoices = Invoice.all
    end

    def show
        @invoice = Invoice.find(params[:id])
    end
end