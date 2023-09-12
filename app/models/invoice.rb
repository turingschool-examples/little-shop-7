require "csv"

class Invoice < ApplicationRecord
  # enum :status, [:completed, :cancelled, :in_progress]
  enum :status, in_progress: "in progress", completed: "completed", cancelled: "cancelled"
end