class Transaction < ApplicationRecord
  belongs_to :invoice

  enum status: {success: 0, failed: 1}
end

