class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  
  scope :top_customers, -> {
    joins(:customer)
      .select('customers.id AS customer_id, customers.first_name, customers.last_name, COUNT(*) AS number_of_transactions')
      .group('customers.id, customers.first_name, customers.last_name')
      .order('number_of_transactions DESC')
      .limit(5)
  }

  enum status: {
                  'cancelled': 0,
                  'in progress': 1,
                  'completed': 2
                  }

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

end