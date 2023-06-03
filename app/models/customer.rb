class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices

  def self.top_5_customers
    joins(:transactions).select("COUNT(transactions.id)").where("transactions.result = 0").group(:id).limit(5)
  end
end