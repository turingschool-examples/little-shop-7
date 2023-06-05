class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates_presence_of :name

  def top_5_customers
    # customers.joins(:transactions).select("customers.*, count(result) as most_success").group(:id).order(:most_success)
    # custies = customers.joins(:transactions).where(transactions: {result: "success"}).group(:id)
    # custies.sort_by{|k,v| v}.take(5)
    customers.joins(:transactions).select("customers.*, COUNT(transactions.id) as transaction_count").where(transactions: {result: "success"}).group("customers.id").order("transaction_count DESC").limit(5)
  end

  enum status: ["enabled", "disabled"] # enabled = 0, disabled = 1

  def self.filter_enabled
    Merchant.where(status: "enabled")
  end

  def self.filter_disabled
    Merchant.where(status: "disabled")
  end
end
