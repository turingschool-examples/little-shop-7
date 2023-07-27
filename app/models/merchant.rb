class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  enum status: {"enable": 0, "disable": 1}

  def top_5_customers
    transactions.joins(invoice: :customer)
      .where('transactions.result = ?', 'success')
      .select('CONCAT(customers.first_name, customers.last_name) AS name, COUNT(transactions) AS total_transactions)')
      .group('customers.name')
      .order('total_transactions DESC')
      .limit(5)
  end
    
  def self.enabled_merchants
    where(status: 0)
  end

  def self.disabled_merchants
    where(status: 1)
  end
end