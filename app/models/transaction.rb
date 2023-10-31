class Transaction < ApplicationRecord
  validates :credit_card_number
  validates :credit_card_expiration_date
  validates :result
  enum :result, {success: 0, failed: 1}
end