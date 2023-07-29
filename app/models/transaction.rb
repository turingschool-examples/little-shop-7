class Transaction < ApplicationRecord
  belongs_to :invoice

  enum result: { 'success': 0, 'failed': 1 }

  validates :credit_card_number, presence: true
  validates :credit_card_expiration_date, presence: true
  validates :result, presence: true
end