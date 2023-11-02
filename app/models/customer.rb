class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  validates :first_name, presence: true
  validates :last_name, presence: true

  def name
    first_name + " " + last_name
  end

  def self.top_5_by_transaction
    top_5 = Customer.joins(invoices: :transactions)
            .where(transactions: {result: "success"})
            .select("customers.*, COUNT(DISTINCT transactions.*) AS num_transactions")
            .group(:id)
            .order(num_transactions: :desc)
            .limit(5)
    # if top_5 = 

    # end
  end
end