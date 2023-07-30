class Merchant < ApplicationRecord 
  validates :name, presence: true
  validates :status, presence: true

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

  def toggle_status
    self.status = !self.status
    save
  end
end