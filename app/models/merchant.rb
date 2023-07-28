class Merchant < ApplicationRecord

  enum status: { disabled: 0, enabled: 1 }
  
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_customers_alt
    customers.top_5_customers_by_transaction(self.id)
  end
  
  def self.find_by_status(merchant_status)
    Merchant.where(status: merchant_status).order(updated_at: :desc)
  end

end
