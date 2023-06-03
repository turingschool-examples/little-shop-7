class Customer < ApplicationRecord
  self.primary_key = :id
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :transactions, through: :invoices

  def self.top_5_customers
    Customer.joins(:transactions)
      .select(:id, :first_name, :last_name, "COUNT(transactions.result) AS transaction_count")
      .where("transactions.result = 1")
      .group(:id)
      .order("transaction_count DESC")
      .limit(5)
  end

  def successful_transaction_count
    transactions.where("transactions.result = 1").count
  end

end