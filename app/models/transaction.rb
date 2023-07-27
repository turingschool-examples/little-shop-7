class Transaction < ApplicationRecord 
  validates :invoice_id, presence: true
  validates :credit_card_number, presence: true
  validates :credit_card_expiration_date, presence: true
  validates :result, presence: true

  belongs_to :invoice
  has_many :customers, through: :invoice
  belongs_to :merchant

  
end