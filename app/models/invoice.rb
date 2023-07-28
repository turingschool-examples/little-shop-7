class Invoice < ApplicationRecord 
  validates :status, presence: true

  enum :status, ["completed", "in progress", "cancelled"]

  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items  
  has_many :transactions
end