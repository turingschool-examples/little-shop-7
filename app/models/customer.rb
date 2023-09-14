require "csv"

class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.top_customers
    find_by_sql(
      "SELECT customers.*, COUNT(transactions.result)
	    FROM customers 
	    INNER JOIN invoices ON invoices.customer_id = customers.id 
	    INNER JOIN transactions ON transactions.invoice_id = invoices.id
	    GROUP BY customers.id
	    ORDER BY count DESC
	    LIMIT 5")
  end
end