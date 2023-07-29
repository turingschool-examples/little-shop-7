class Transaction < ApplicationRecord
  belongs_to :invoice
  enum result: { 'success': 1, 'failed': 0}
end