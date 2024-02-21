class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy

  validates :status, presence: true
  
  enum status: ["In Progress", "Cancelled", "Completed"]
end
