class Merchant < ApplicationRecord
   has_many :items
   has_many :invoices, through: :items
   has_many :customers, through: :invoices
   
   validates :name, presence: true

   def top_five_customers
      Customer.select("customers.*, count(transactions.id) as count_transactions")
      .joins(:transactions).where(transactions: {result: "success"})
      .group('customers.id')
      .order("count_transactions DESC")
      .limit(5)
   end

  
end