class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  
  validates :name, presence: true

  def items_to_ship
    items.joins(:invoice_items)
    .joins(:invoices)
    .where.not(invoice_items: {status: 2})
    .select("id", "items.name, invoices.id as invoice_id, invoice_items.status, invoices.created_at as created_at").order(created_at: :desc).uniq
  end

  def top_five_customers
    customers.joins(:transactions) # can join directly bc of our relations above
    .where(transactions: {result: 0}) # for all successful transactions
    .group("customers.id") # group customers
    .order("count(transactions.id) DESC") # sort by # of transactions in desc order
    .limit(5)
  end

  def top_five_customers_count
    customers.joins(:transactions) # can join directly bc of our relations above
    .where(transactions: {result: 0}) # for all successful transactions
    .group("customers.id") # group customers
    .order("count(transactions.id) DESC") # sort by # of transactions in desc order
    .limit(5)
    .count("transactions.id")
  end

  def enabled_items
    items.where(status: "enabled")
  end

  def disabled_items
    items.where(status: "disabled")
  end

  def merchant_invoices(merchant_id)
    invoices.joins(:items)
    .where(items: {merchant_id: merchant_id})
    .select("id", "invoices.id as invoice_id").uniq
  end

  def top_five_items
    items.joins(:transactions)
    .joins(:invoice_items)
    .where(transactions: {result: 0})
    .group("items.id")
    .order("sum(invoice_items.unit_price) DESC")
    .limit(5)
  end

  def self.top_five_merchants_by_revenue
    joins(:transactions) # join necessary tables
    .where('transactions.result = 0') # filter by successful transactions 
    .group('merchants.id') # group records by merchant
    .select('merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue')  # Calculate total revenue
    .order('total_revenue DESC')
    .limit(5)
  end

  def total_revenue
    invoices
    .joins(:transactions)
    .where(transactions: { result: 0 }) # Filter by successful transactions
    .sum('invoice_items.unit_price * invoice_items.quantity')
  end
end


# expect("#{@merchant2.name}: #{@total_revenue2}").to appear_before("#{@merchant3.name}: #{@total_revenue3}")
#     expect("#{@merchant3.name}: #{@total_revenue3}").to appear_before("#{@merchant4.name}: #{@total_revenue4}")
#     expect("#{@merchant4.name}: #{@total_revenue4}").to appear_before("#{@merchant5.name}: #{@total_revenue5}")
#     expect("#{@merchant5.name}: #{@total_revenue5}").to_not appear_before("#{@merchant1.name}: #{@total_revenue1}")