class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates_presence_of :name

  def top_5_custies
    require 'pry'; binding.pry
  end
end
# customers.joins(:transactions).select("customers.*, count(result) as most_success").group(:id).order(:most_success)
