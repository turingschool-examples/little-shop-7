class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  
  validates :first_name, :last_name, presence: true

  def self.top_five_customers(merchant)
    joins(:transactions).joins(:merchants).where(transactions: {result: 0}, merchants: {id: merchant.id}).select("customers.*, count(transactions) as transaction_count").group(:id).order(transaction_count: :desc).limit(5)
  end
  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end