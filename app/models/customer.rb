class Customer < ApplicationRecord
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :first_name, :last_name

  #class methods
  def self.top_5_customers
    joins(invoices: :transactions).select("customers.*, COUNT(transactions.id) as transactions_count").where(transactions: { result:"success"}).group("customers.id").order("transactions_count DESC").limit(5)
  end

  #instance methods
  def customer_success_trans
    self.transactions.where(result:"success").count
  end
end
