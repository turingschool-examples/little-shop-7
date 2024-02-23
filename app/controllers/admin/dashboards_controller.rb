class Admin::DashboardsController < ApplicationController
    def index
        # require'pry';binding.pry
        @top_customers = Customer.top_customers
    end
end