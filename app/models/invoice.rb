require "csv"

class Invoice < ApplicationRecord
  enum status: [:completed, :cancelled, :in_progress]
end