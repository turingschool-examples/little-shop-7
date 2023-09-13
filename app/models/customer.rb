class Customer < ApplicationRecord
  has_many :invoices

  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.order_customers_by_transactions
    joins(invoices: :transactions)
    .where(transactions: {result: 1})
    .group('customers.id, customers.first_name, customers.last_name')
    .order("COUNT(transactions.id) DESC")
    .limit(5)
  end
end
