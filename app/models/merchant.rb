class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  enum status: {enabled: "Enabled", disabled: "Disabled"}

  def self.top_merchants_by_revenue
    Merchant
      .joins(invoices: [:transactions, :invoice_items])
      .joins('INNER JOIN items ON invoice_items.item_id = items.id')
      .where(transactions: { result: 'success' })
      .group('merchants.id, merchants.name').select('merchants.id, merchants.name, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue')
      .order('revenue DESC').
      limit(5)
  end

  def distinct_invoices
    invoices.distinct
  end
end