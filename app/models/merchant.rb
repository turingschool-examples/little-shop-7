class Merchant < ApplicationRecord
  validates :name
  has_many :items
end