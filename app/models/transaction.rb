class Transaction < ApplicationRecord
  belongs_to :invoice
  belongs_to :customer, through: :invoice
end
