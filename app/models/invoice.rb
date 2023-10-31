class Invoice < ApplicationRecord
  validates :status
  enum :status, {"in progress": 0, completed: 1, cancelled: 2}
end