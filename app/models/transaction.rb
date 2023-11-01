class Transaction < ApplicationRecord
  belongs_to :invoice

  enum status: {"failed": 0, "success": 1}
end