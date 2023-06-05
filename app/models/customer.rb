class Customer < ApplicationRecord
  self.primary_key = :id
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :transactions, through: :invoices


end