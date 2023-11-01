class Invoice < ApplicationRecord
  belongs_to :merchant
  has_many :items
  enum status: {"in progress": 0, "completed": 1, "cancelled": 2}
end