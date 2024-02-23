class Transaction < ApplicationRecord
   belongs_to :invoice
   has_one :customer, through: :invoice
   has_one :item, through: :invoice
   
   enum :result, [ "success", "failed"]
end