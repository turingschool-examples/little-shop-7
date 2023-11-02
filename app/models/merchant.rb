class Merchant < ApplicationRecord
  has_many :items
  # need relationship specs
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  
  validates :name, presence: true

  def top_five_customers
    customers.joins(invoices: :transactions).where(transactions: {result: 0}).select("customers.*, count(transactions)").group("customers.id").order(count: :desc).limit(5)
  end
end