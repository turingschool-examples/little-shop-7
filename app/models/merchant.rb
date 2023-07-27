class Merchant < ApplicationRecord 
  validates :name, presence: true
  
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices


  def top_five_customers
    require 'pry'; binding.pry
    Customer
    .joins(:transactions)
    .where(transactions: { result: "success" })
    .group('customers.id')
    .order('COUNT(transactions.id) DESC')
    .limit(5)
  end
end