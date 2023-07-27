class Customer < ApplicationRecord 
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  def self.top_5_customers
    joins(:transactions).where(transactions: {result: "success"}).select("customers.*, count(result) AS result_count").group(:id).order("result_count desc").limit(5)
  end
  
  def successful_transaction_count
    transactions.where(result: :success).count
  end
end