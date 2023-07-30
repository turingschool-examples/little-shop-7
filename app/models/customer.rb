class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name

  
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  def self.top_customers
    select("customers.*, CONCAT(first_name, ' ', last_name) AS full_name, COUNT(DISTINCT transactions.id) AS successful_transactions_count")
      .joins(invoices: :transactions)
      .where(transactions: { result: 'success' })
      .group('customers.id')
      .order('successful_transactions_count DESC')
      .limit(5)
  end
end