class Invoice < ApplicationRecord
  belongs_to :customer
  enum :status, ["pending", "packaged", "shipped"]
end