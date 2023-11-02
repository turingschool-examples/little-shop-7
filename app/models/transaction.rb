class Transaction < ApplicationRecord
  belongs_to :invoice

  validates :credit_card_number, :credit_card_expiration_date, :result, presence: true
  
  enum :result, {success: 0, failed: 1}
end