class Invoice < ApplicationRecord 
  validates :status, presence: true

  enum :status, ["completed", "in progress", "cancelled"]

end