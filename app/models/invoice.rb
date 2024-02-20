class Invoice < ApplicationRecord
  belongs_to :customer

  validates :status, presence: true
  
  enum status: ["In Progress", "Cancelled", "Completed"]
end
