class Customer < ApplicationRecord 
  has_many :invoices, dependent: :destroy 
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoices
  has_many :merchants, through: :items

  def self.top_5_customers
    joins(:transactions).where(transactions: {result: "success"}).select("customers.*, count(result) AS successful_transactions").group(:id).order("successful_transactions desc").limit(5)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.top_5_customers_by_transaction(merchant_id)
    x = Customer.find_by_sql(
      "SELECT COUNT(DISTINCT transactions.id) AS num_transactions, customers.* 
      FROM customers 
        INNER JOIN invoices ON customers.id = invoices.customer_id
        INNER JOIN invoice_items ON invoices.id = invoice_items.invoice_id 
        INNER JOIN items ON invoice_items.item_id = items.id 
        INNER JOIN transactions ON transactions.invoice_id = invoices.id
      WHERE items.merchant_id = #{merchant_id} AND (transactions.result = 'success') 
      GROUP BY customers.id
      ORDER BY num_transactions desc, customers.last_name
      LIMIT 5")
      # require 'pry'; binding.pry
  end
  
  def successful_transaction_count
    transactions.where(result: :success).count
  end
end