class Merchant <ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :invoice_items, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
  enum status: ["disabled", "enabled"]

  def top_customers
    # find_by_sql(
    #   "SELECT customers.*, COUNT(invoices.status)
	  #   FROM customers 
	  #   INNER JOIN invoices ON invoices.customer_id = customers.id 
	  #   GROUP BY customers.id
	  #   ORDER BY count DESC
	  #   LIMIT 5")
    
      self.customers.select("customers.*, COUNT(transactions.id)")
      .joins(:transactions) #invoices: optional
      .where("transactions.result = 0")
      .group("customers.id")
      .order("count desc")
      .limit(5)
  end

  def items_to_ship
      self.items.select("items.*, invoice_items.invoice_id, invoices.created_at")
      .joins(invoices: :invoice_items) #invoices: optional
      .where("invoice_items.status != 2")
  end

  def top_five_items
    self.items.select("items.* SUM(items.total_cost)")
    .where()
  end
end