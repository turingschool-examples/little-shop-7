class Customer < ApplicationRecord 
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices, dependent: :destroy
  has_many :items, through: :invoice_items, dependent: :destroy 
  has_many :merchants, through: :items, dependent: :destroy
  
  # def successful_transaction_count
  #   transactions.where(transactions: {result: "success"}).count
  # end


  def full_name
    "#{first_name} #{last_name}"
  end
# merchant.customers
  def self.top_5_customers_by_transaction
    x = joins(:transactions)
    .where(transactions: {result: "success"})
    .select("customers.*, count(transactions) AS result_count")
    .group("customers.id")
    .distinct
    .order("result_count desc")
    require 'pry'; binding.pry
  end
  

  def successful_transaction_count
    transactions.where(result: :success).count
  end
end