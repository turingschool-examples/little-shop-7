class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, through: :items, dependent: :destroy
end