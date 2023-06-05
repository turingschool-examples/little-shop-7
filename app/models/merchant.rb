class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  validates_presence_of :name

  enum status: ["enabled", "disabled"] # enabled = 0, disabled = 1

  # def total_revenue
  #   thing = invoice_items.joins(invoice: :transactions).select('sum(invoice_items.quantity*invoice_items.unit_price) as revenue').where('transactions.result = 0').group(:id)
  #   require 'pry'; binding.pry
  # end

  def self.filter_enabled
    Merchant.where(status: "enabled")
  end

  def self.filter_disabled
    Merchant.where(status: "disabled")
  end

  def self.top_5_by_revenue
    top_5 = joins(items: [{invoice_items: { invoice: :transactions } }]).select('merchants.*, sum(invoice_items.quantity*invoice_items.unit_price) as revenue').where('transactions.result = 0').group(:id).order('revenue DESC').limit(5)
  end
end
