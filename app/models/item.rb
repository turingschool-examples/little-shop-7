class Item < ApplicationRecord
  validates_presence_of :name,
                        :description, 
                        :unit_price

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  enum status: { enabled: 0, disabled: 1 }

  def top_sales_date
    date = (Invoice.find_by_sql ["SELECT 
    invoice_items.item_id,
    sum(invoice_items.quantity * invoice_items.unit_price),
    CAST (invoices.created_at AS DATE) AS date
    FROM invoices
    JOIN invoice_items ON invoices.id = invoice_items.invoice_id 
    WHERE invoice_items.item_id = #{self.id}
    GROUP BY 
      invoice_items.item_id,
      date
    Order BY sum DESC, date
    LIMIT 1;"])
    date.first.date.to_fs(:long)
  end
end
