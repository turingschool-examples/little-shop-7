class Merchant < ApplicationRecord
  has_many :items
  
  validates :name, presence: true

  def top_customers
    
  end
end