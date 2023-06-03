class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  validates :name, presence: true

  def top_five_customers
    Merchant.joins(invoice_items: [invoice: [customer: :transactions]])
            .where(merchants: { id: id }, transactions: { result: "success" })
            .select("customers.*, count(transactions.id) as transaction_count")
            .group("customers.id")
            .order(count: :desc)
            .limit(5)
  end
end