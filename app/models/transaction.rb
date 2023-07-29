class Transaction < ApplicationRecord
  belongs_to :invoice

  enum result: { 'success': 0, 'failed': 1 }

  validates_length_of :credit_card_number, is: 16
  validates :credit_card_expiration_date, presence: true
  validates :result, presence: true
end