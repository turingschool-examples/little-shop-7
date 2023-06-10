class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  validates_presence_of :name
  validates_presence_of :code, uniqueness: true
  validates :status, :value, :coupon_type, numericality: { only_integer: true }

  enum status: ["disabled", "activated"]
  enum coupon_type: ["percent", "dollar"]

end
