class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  def top_5_customers_by_successful_transactions
    Customer
      .joins(invoices: :transactions)
      .joins("INNER JOIN invoice_items ON invoice_items.invoice_id = invoices.id")
      .joins("INNER JOIN items ON invoice_items.item_id = items.id")
      .where("items.merchant_id = ?", id)
      .where(transactions: { result: 0 }) # success = 0 if enum
      .select("customers.*, COUNT(transactions.id) AS transaction_count")
      .group("customers.id")
      .order("transaction_count DESC")
      .limit(5)
  end

  def items_ready_to_ship
    invoice_items
      .joins(:invoice)
      .where.not(status: [:shipped])
      .where.not(invoices: { status: :cancelled })
      .order('invoices.created_at')
  end
end
