class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum :status, { "in progress": 0, completed: 1, cancelled: 2 }

  def format_created_date
    created_at.to_date.to_formatted_s(:weekday_month_day_year)
  end

  def total_revenue
    invoice_items.sum("unit_price * quantity") # do we need to convert this from cents to dollars?
  end

  def total_revenue_by_merchant(merchant)
    merchant_id = merchant.id
    item_ids = merchant.items.pluck(:id)
    merchant_invoice_items = InvoiceItem.where(item_id: item_ids, invoice_id: id)

    total_revenue_in_cents = merchant_invoice_items.sum do |invoice_item|
      invoice_item.unit_price * invoice_item.quantity
    end
      '%.2f' % "#{total_revenue_in_cents/100}"
  end
end
