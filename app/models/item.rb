class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  def unit_price_formatted
    unit_price.to_f / 100
  end

  def self.ready_to_ship 
    joins(:invoice_items)
      .where("invoice_items.status = ?", "packaged") 
  end

  #don't love this method because I'm not certain it's doing what I want here
  # Is this stuff on line 15 doing it as a SQL with the quotes? how can I write this to work with AR?
end
