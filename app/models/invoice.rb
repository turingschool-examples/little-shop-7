require "csv"

class Invoice < ApplicationRecord
  enum status: ["completed", "cancelled", "in progress"]
end