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
    .select("items.*, invoices.id as invoice_id")
    .where.not("invoice_items.status = 2")
    .where.not("invoices.status = 2")
    .distinct
    .order("created_at desc")
  end

  def invoice_id_item
    invoice_items.invoice_id
  end
end
