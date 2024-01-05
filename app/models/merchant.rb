class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :transactions, through: :invoices
  validates :name, presence: true

  enum status: {
    disabled: 0,
    enabled: 1
  }
end
