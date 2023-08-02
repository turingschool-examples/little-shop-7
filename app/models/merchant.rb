class Merchant < ApplicationRecord 
  validates :name, presence: true
  validates :status, inclusion: { in: [true, false] }, exclusion: nil

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def top_five_customers
    customers.joins(:transactions)
                        .where("transactions.result = 'success'") 
                        .group('customers.id')
                        .select("CONCAT(customers.first_name, ' ', customers.last_name) AS customer_name, customers.*, COUNT(DISTINCT transactions.id) AS transaction_count")
                        .order('transaction_count DESC')
                        .limit(5)
  end

  def pending_items
    items.joins(:invoice_items)
    .where("invoice_items.status >= 1")
    .order(created_at: :asc)
  end


  def enabled_items
    items.where(status: true)
  end

  def disabled_items
    items.where(status: false)
  end

  def popular_items
    items.joins(:invoice_items)
    .where("invoice_items.status = 2")
    .group(:id)
    .select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
    .order("revenue DESC")
    .limit(5)
  end

  def toggle_status
    if self.status
      self.update_attribute(:status, false)
    else
      self.update_attribute(:status, true)
    end
  end

  def self.top_5_by_revenue
    joins(:invoices)
      .merge(Invoice.completed)
      .group('merchants.id')
      .order(Arel.sql('SUM(invoice_items.unit_price * invoice_items.quantity) DESC'))
      .limit(5)
  end

  def revenue
    invoices.completed.joins(:invoice_items).sum('invoice_items.unit_price * invoice_items.quantity')
  end
end


