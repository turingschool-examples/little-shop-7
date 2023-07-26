class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  enum status: {"enable": 0, "disable": 1}

  def self.enabled_merchants
    where(status: 0)
  end

  def self.disabled_merchants
    where(status: 1)
  end
end