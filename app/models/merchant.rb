class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_customers_alt
    customers.top_5_customers_by_transaction(self.id)
  end
  
  def items_ready
    items.joins(:invoices)
    .select("items.*, invoices.id AS invoice_id, invoices.created_at, TO_CHAR(invoices.created_at, 'FMDay, FMMonth FMDD, YYYY') AS invoice_created_at")
    .where.not("invoice_items.status = 2")
    .where.not("invoices.status = 2")
    .distinct
    .order("invoices.created_at desc")
  end
end
