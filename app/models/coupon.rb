class Coupon < ApplicationRecord
  belongs_to :merchant
  belongs_to :invoice, optional: true

  validates_presence_of :name, :code
  validates :status, :value, :type, numericality: { only_integer: true }
end
