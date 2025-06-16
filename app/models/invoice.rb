class Invoice < ApplicationRecord
    belongs_to :customer
    has_many :invoice_items

    enum status: {
        pending: 0,
        shipped: 1,
        returned: 2
    }
end
