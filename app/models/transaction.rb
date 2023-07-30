class Transaction < ApplicationRecord
  belongs_to :invoice
  validates_length_of :credit_card_number, is: 16
  # validates :credit_card_expiration_date, presence: true
  validates :result, presence: true

  enum result: { 'success': 1, 'failed': 0}
end