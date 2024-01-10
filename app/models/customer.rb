class Customer < ApplicationRecord
  has_many :invoices

  def self.top_5_spenders
    #Return an array of the top 5 customers with most succesful transactions
    #Start with all customers
    #join with invoices
    #join with transactions
    # filter out rows that do not have a result value of 1 aka "successful" transactions
    #count each customers transactions
        # group by customer.id
    # order by most succesful transactions
    #limit to 5 customers
    Customer
    .joins(invoices: :transactions)
    .where(transactions: { result: 1 })
    .group("customers.id")
    .select("customers.*, count(transactions.id) AS successful_transactions")
    .order(successful_transactions: :desc) 
    .limit(5)
  end
end

