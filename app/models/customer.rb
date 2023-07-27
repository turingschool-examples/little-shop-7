class Customer < ApplicationRecord 
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices, dependent: :destroy
  has_many :items, through: :invoice_items, dependent: :destroy 
  has_many :merchants, through: :items, dependent: :destroy

  def self.top_5_customers
    joins(:transactions).where(transactions: {result: "success"}).select("customers.*, count(result) AS result_count").group(:id).order("result_count desc").limit(5)
  end
  
  def successful_transaction_count
    transactions.where(result: :success).count
  end
end