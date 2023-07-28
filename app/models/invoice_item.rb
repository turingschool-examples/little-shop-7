class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  enum status: {
                'packaged': 0,
                'pending': 1,
                'shipped': 2
                }

  def format_selling_price
    unit_price_in_cents = self.unit_price
    dollars = unit_price_in_cents / 100
    cents = unit_price_in_cents % 100
    sprintf("$%d.%02d", dollars, cents)
  end              
end