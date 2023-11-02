class Admin::DashboardsController < ApplicationController
  def welcome
    @dashboard = Admin::Dashboard.new
  end
end
