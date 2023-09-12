require "csv"

class Invoice < ApplicationRecord
  enum :status, in_progress: "in progress", completed: "completed", cancelled: "cancelled"
end