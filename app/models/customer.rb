class Customer < ApplicationRecord
  has_many :invoices

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def successful_orders_count
    
  end
end