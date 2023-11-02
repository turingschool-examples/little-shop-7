class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  
  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.top_customers(merchant)
    joins(invoices: :transactions).where(transactions: {result: 0}).select("customers.*, count(transactions)").group(:id).order(count: :desc).limit(5)
  end
end