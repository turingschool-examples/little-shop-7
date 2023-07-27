class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  enum status: { "enable": 0, "disable": 1 }

  # Instance Methods
  def top_5_customers
    transactions.joins(invoice: :customer)
      .where('transactions.result = ?', 0)
      .select("CONCAT(customers.first_name,' ', customers.last_name) AS full_name, COUNT(transactions.id) AS transaction_count")
      .group('full_name')
      .order('transaction_count DESC')
      .limit(5)
      .to_a
  end

  def ready_to_ship
    invoice_items.joins(:item)
      .where(status: "pending")
      .select("items.*, invoice_items.*")
      .distinct
  end

  # Class methods
  def self.enabled_merchants
    where(status: 0)
  end

  def self.disabled_merchants
    where(status: 1)
  end
end