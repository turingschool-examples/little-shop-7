class Transaction < ApplicationRecord
  enum :result, success: "success", failed: "failed"
end