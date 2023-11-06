class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items

  validates :name, presence: true
  
  def top_5_customers_from_transactions
    binding.pry
    Customer.joins(invoices: :transactions)
    .where(transactions: {result: "success"})
    .select("customers.*, COUNT(DISTINCT transactions.*) AS num_transactions")
    .group(:id)
    .order(num_transactions: :desc)
    .limit(5)
  end

  def popular_items
    self.items.select('items.id, items.name, invoice_items.unit_price, (SUM(invoice_items.quantity) * invoice_items.unit_price * 0.01) as total_revenue')
    .joins(invoices: :transactions)
    .where(transactions: { result: 1 })
    .group('items.id, items.name, invoice_items.unit_price')
    .order('total_revenue DESC')
    .limit(5)
  end
end