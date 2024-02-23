class Customer < ApplicationRecord
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :transactions, through: :invoices

  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.top_customers
    Customer
    .joins(:transactions)
    .where(transactions: {result: "success"})
    .group("customers.id")
    .order("COUNT(transactions.id) DESC")
    .limit(5)
    .select("customers.*", "COUNT(transactions.id) AS transaction_count")
  end
end
