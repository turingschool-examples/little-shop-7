class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items

  validates :name, presence: true
  

  def popular_items
    self.items.select('items.id, items.name, invoice_items.unit_price, (SUM(invoice_items.quantity) * invoice_items.unit_price) as total_revenue')
    .joins(invoices: :transactions)
    .where(transactions: { result: 1 })
    .group('items.id, items.name, invoice_items.unit_price')
    .order('total_revenue DESC')
    .limit(5)
  end

  def items_ready_to_ship_ordered_oldest_to_newest
    items_ready_to_ship = []

    self.items.each do |item|
      item.invoice_items.each do |invoice_item|
        if invoice_item.status != 'shipped'
          items_ready_to_ship << {
            name: item.name,
            invoice_id: invoice_item.invoice_id,
            date: invoice_item.invoice.created_at.strftime('%A, %B %d, %Y')
          }
        end
      end
    end
    items_ready_to_ship.sort_by! { |item| Date.strptime(item[:date], '%A, %B %d, %Y') }
  end
end