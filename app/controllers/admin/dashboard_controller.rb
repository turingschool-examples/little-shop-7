class Admin::DashboardController < ApplicationController

  def index
    @top_customers = Customer.joins(invoices: :transactions)
                            .where(invoices: { status: 'completed' }, transactions: { result: 'success'})
                            .group(:id)
                            .order('COUNT(transactions.id) DESC')
                            .limit(5)
                            .select('customers.*, COUNT(transactions.id) as transaction_count')
  end

end
