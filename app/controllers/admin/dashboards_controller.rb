class Admin::DashboardsController < ApplicationController
    def index
        # require'pry';binding.pry
        @top_customers = Merchant.top_customers
    end
end