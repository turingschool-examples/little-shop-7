class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :customers, through: :invoices

  def favorite_customers
    # WHAT WE WANT: top 5 customers with the most successful transactions
    # | customer_name | count_transactions
    # |----------------------------------
    # | John          |      5
    # | Ethan         |      4
    # | Zanna         |      3
    # | Jorja         |      3
    # | Daniel        |      2

    # get all the transactions related to this merchant
    # group them by invoice id, which is related to a customer
    # do a count and group by customer_id
    # get the customer name

    # customers(order: {customer.merch_transactions(self.id), desc}).limit(5) 
Customer.join(transactions: :invoice)
  end

  def transaction_count
    transactions.count
  end
end