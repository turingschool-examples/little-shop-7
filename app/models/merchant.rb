class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items

  validates :name, presence: true
  

  def popular_items
    require 'pry'; binding.pry
    self.items.find_by_sql("select a.id, a.name, sum(b.quantity) as total_quant, b.unit_price, (sum(b.quantity)*b.unit_price) as total_revenue from items as a inner join invoice_items as b on a.id = b.item_id inner join invoices as c on b.invoice_id = c.id inner join transactions as d on c.id = d.invoice_id where d.result = 1 group by a.id, a.name, b.unit_price order by total_revenue desc limit (5)")
  end

  #self.items.joins(invoices: :transactions).where(transactions: {result: "success"}

  #items.joins(invoices: :transactions).where(transactions: {result: "success"}).select("items.id, invoice_items.quantity, invoice_items.unit_price")

  # select("items.id, items.name, (sum(invoice_items.quantity)*invoice_items.unit_price) as total_revenue").joins(invoice_items: :transactions)
end