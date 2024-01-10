class Customer < ApplicationRecord
  has_many :invoices

  def self.top_five_by_transaction
    Customer.joins(invoices: :transactions)
      .select("customers.*, COUNT(transactions.id) AS num_trans")
      .where("transactions.result = 'success'")
      .group("customers.id")
      .order("num_trans DESC")
      .limit(5)
  end

end