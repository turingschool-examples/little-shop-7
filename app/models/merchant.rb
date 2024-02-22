class Merchant < ApplicationRecord
  
  validates :name, presence: true

  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  def top_five_cust
    self.transactions.joins(invoice: :customer) #what tables do we need
      .where("transactions.result = ?", "0" ) # are there conditions for the data I want back
      .select("customers.id, CONCAT(customers.first_name, ' ', customers.last_name) AS full_name, COUNT(transactions) AS successful_transactions") #select is what I want back
      .group("customers.id") #how do I want to organize the data
      .order("successful_transactions DESC")  #how the group will be returned
      .limit(5) #how many 
  end

  def not_shipped_invoices
    # x=items.joins(:invoice_items, :invoice)
    # .where("invoice_items.status != 2")
    # .select("distinct(invoices.id), invoices.created_at, items.name")
    # .group("invoices.id")
    # .order("invoices.created_at")
  
    # invoices.invoices_with_unshipped_items_oldest_to_newest
    self.invoice_items.where("invoice_items.status != 2")
  end
end