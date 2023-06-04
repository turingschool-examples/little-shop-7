class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  validates_presence_of :name

  enum status: ["enabled", "disabled"] # enabled = 0, disabled = 1

  def self.filter_enabled
    Merchant.where(status: "enabled")
  end

  def self.filter_disabled
    Merchant.where(status: "disabled")
  end

  def total_revenue
    require 'pry'; binding.pry
  end
end
