class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def top_five_customers
    customers.joins(:transactions)
    .group(:id)
    .where( transactions: {result: 0})
    .order("COUNT(transactions.id) DESC")
    .limit(5)  
  end

  def items_ready_to_ship
    # invoice_items.where(status: 1)
    # require 'pry'; binding.pry
    Item.joins(:invoice_items).where(invoice_items: {status: 1}).distinct.pluck(:name)
  end
end