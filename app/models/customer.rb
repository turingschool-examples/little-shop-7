class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name

  has_many :invoices
  has_many :transactions, through: :invoices

  def self.top_five
    Customer.joins(:invoices, :transactions)
                       .where(transactions: { result: 'success' })
                       .group('customers.first_name', 'customers.last_name', 'invoices.customer_id')
                       .select("CONCAT(customers.first_name, ' ', customers.last_name) AS customer_name, invoices.customer_id AS invoice_customer, COUNT(transactions.*) AS transaction_count")
                       .order('transaction_count DESC')
                       .limit(5)
  end
end