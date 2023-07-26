class Customer < ApplicationRecord 
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :items, through: :invoices
  
  def succesful_transaction_count
    Customer.select(transactions.*).where("transaction.status = 'success'").count
  end
end