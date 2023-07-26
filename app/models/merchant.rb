class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  enum status: {"enable": 0, "disable": 1}

  def top_5_customers
    # what type of object do i need? customers
    # model name Merchant
    # need data from Customer invoices
    # Status "completed"
    # data should be formatted by max number of "completed" per customer
    # limit 5 customers
  end
end