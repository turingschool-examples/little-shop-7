class Admin::AdminsController < ApplicationController
  def show
    @top5 = Customer.total_top_five_customers
    require 'pry'; binding.pry
  end
end