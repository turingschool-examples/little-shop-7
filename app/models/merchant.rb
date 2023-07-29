class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_customers_alt
    customers.top_5_customers_by_transaction(self.id)
  end
  
  def distinct_invoices
    invoices.distinct
  end

end
