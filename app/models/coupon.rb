class Coupon < ApplicationRecord
  belongs_to :merchant
  belongs_to :invoice, optional: true

  validates_presence_of :name
  validates_presence_of :code, uniqueness: true
  validates :status, :value, :type, numericality: { only_integer: true }

  enum status: ["disabled", "activated"]
  enum type: ["percent", "dollar"]

end
