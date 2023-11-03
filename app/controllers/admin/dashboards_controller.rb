class Admin::DashboardsController < ApplicationController
  def welcome
    @top5 = Customer.total_top_five_customers
    @items_to_ship = InvoiceItem.items_to_ship
  end
end