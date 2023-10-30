class CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def new
  end
end