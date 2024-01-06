class Merchant < ApplicationRecord
  validates :name, presence: true

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
            .where(transactions: { result: 'success' })  # Adjust based on how you define a successful transaction
            .group('customers.id')
            .order('transactions_count DESC')
            .limit(5)
  end

  def not_yet_shipped
    InvoiceItem.find_by_sql ["SELECT
    items.name,
    invoice_items.invoice_id
  FROM
    items
    JOIN invoice_items ON items.id = invoice_items.item_id
  WHERE
    items.merchant_id = #{self.id}
    AND (invoice_items.status = '0'
      OR invoice_items.status = '1')"]
  end
end
