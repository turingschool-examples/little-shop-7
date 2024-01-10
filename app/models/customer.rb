class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  
  def self.top_customers_by_successful_transaction
    select('customers.*, COUNT(transactions.id) AS transactions_count')
      .joins(invoices: :transactions)
      .where(transactions: { result: 'success' })
      .group('customers.id')
      .order('transactions_count DESC')
      .limit(5)
  end
end