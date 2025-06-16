class Invoice < ApplicationRecord
    belongs_to :customer
    has_many :invoice_items

    enum status: {
        cancelled: 0,
        in_progress: 1,
        completedok: 2
    }
end
