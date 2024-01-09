class Merchant < ApplicationRecord
  validates :name, presence: true
  enum status: { disabled: 0, enabled: 1 }

  has_many :items, dependent: :destroy
  has_many :invoices, through: :items
  has_many :invoice_items, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  

  def transactions
    Transaction.joins(invoice: { invoice_items: :item }).where(items: { merchant_id: id })
  end

  def top_customers
    Customer.joins(invoices: :transactions)
            .joins("JOIN invoice_items ON invoice_items.invoice_id = invoices.id")
            .joins("JOIN items ON items.id = invoice_items.item_id AND items.merchant_id = #{id}")
            .select('customers.*, COUNT(transactions.id) AS transactions_count')
            .where(transactions: { result: 'success' })
            .group('customers.id')
            .order('transactions_count DESC')
            .limit(5)
  end

  def not_yet_shipped_ascending
    InvoiceItem.find_by_sql ["SELECT
    items.name,
    invoice_items.invoice_id,
    invoice_items.status,
    invoices.created_at
  FROM
    items
    JOIN invoice_items ON items.id = invoice_items.item_id
    JOIN invoices ON invoices.id = invoice_items.invoice_id
  WHERE
    items.merchant_id = #{id}
    AND (invoice_items.status = '0'
    OR invoice_items.status = '1')
    ORDER BY invoices.created_at;"]
  end

  def top_earning_items
    Item.find_by_sql(["SELECT items.*, SUM(invoice_items.quantity * invoice_items.unit_price) as total_revenue
    FROM items
    INNER JOIN invoice_items ON items.id = invoice_items.item_id
    WHERE items.merchant_id = ?
    GROUP BY items.id
    ORDER BY total_revenue DESC
    LIMIT 5", id])
  end

  def self.top_five_merchants
    self.joins([invoices: :transactions], :invoice_items)
      .where("transactions.result = ?", 0)
      .select("merchants.name, merchants.id, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
      .group("merchants.id")
      .order("revenue DESC")
      .limit(5)
  end
end
