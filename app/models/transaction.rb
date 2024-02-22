class Transaction < ApplicationRecord
  validates :credit_card_number, presence: true
  validates :credit_card_expiration_date, presence: true
  validates :result, presence: true
  
  belongs_to :invoice
  # has_many :invoice_items, through: :invoices
  # has_many :items, through: :invoice_items
  # has_many :merchants, through: :items

  enum result: ["success", "failed"]
end
