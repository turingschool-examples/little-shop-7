class Merchant < ApplicationRecord
  has_many :items
  # need relationship specs
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  
  validates :name, presence: true

  def top_five_customers
    customers.joins(:transactions) # can join directly bc of our relations above
    .where(transactions: {result: 0}) # for all successful transactions
    .group("customers.id") # group customers
    .order("count(transactions.id) DESC") # sort by # of transactions in desc order
    .limit(5)
    .count("transactions.id")
  end
end