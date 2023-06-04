class Customer < ApplicationRecord
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  # has_many :items, through: :invoice_items
  # has_many :merchants, through: :items

  validates_presence_of :first_name, :last_name

  def top_5
    # joins(invoices: {invoice_items: { item: :merchant }, transactions: :invoice })
    # require 'pry'; binding.pry
  end

end
