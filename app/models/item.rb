class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: { greater_than: 0, only_integer: true }


  enum status: {
  Disable: 0,  
  Enable: 1
  }



  def change_status(status)
    if status == "Enable"
      update(status: 1)
    elsif status == "Disable"
      update(status: 0)
    end
  end
  

end
