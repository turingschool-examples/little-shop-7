class Transaction < ApplicationRecord
  enum result: [:success, :failed]
  belongs_to :invoice
end