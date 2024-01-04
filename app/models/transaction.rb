class Transaction < ApplicationRecord
  belongs_to :invoice

  enum :result, { failure: 0, success: 1}
end
