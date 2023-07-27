class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_customers
    customers.joins(invoices: :transactions)
      .where("transactions.result = ?","success")
      # .where(transactions: {result: "success"})
      .select("customers.*, count(transactions) AS success_transactions")
      # .select("concat(customers.first_name, ' ', customers.last_name) AS full_name, count(transactions) AS success_transactions")
      .group("customers.id")
      # .group("full_name")
      .order("success_transactions desc")
      .limit(5)
    # joins(:customer).order(customer.succesful_transaction_count).limit(5)
    # customers(order: {customer.merch_transactions(self.id), desc}).limit(5) 
    # customers.order(customer.succesful_transaction_count, desc).limit(5)
  end


end