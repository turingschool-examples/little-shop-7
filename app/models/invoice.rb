class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  validates :status, presence: true
  
  enum status: ["in progress", "cancelled", "completed"]

  # class method for checking status of invoice
  def self.invoices_with_unshipped_items
    Invoice.select("invoices.*").joins(:invoice_items).where("invoice_items.status != 2")
  end

  def self.oldest_to_newest
    Invoice.order(:created_at)
  end

  # Can't quite figure out how these methods can come together for some reason. may just be in need of a break, User Story 23

  # def self.invoices_with_unshipped_items_oldest_to_newest
  #   Invoice.select("invoices.*").joins(:invoice_items).where("invoice_items.status != 2").order(:created_at)
  # end

  # not sure if this is a method that we want to use/make for formatting our date, or if it should live in the view user story 23

  # def format_date
  #   Invoice.select('strftime("%A, %B %d, %Y"invoices.created_at) as formatted_date').where("invoice.id = #{self.id}")
  # end

end
