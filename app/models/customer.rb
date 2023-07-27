class Customer < ApplicationRecord 
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :items, through: :invoices
  
  # def self.succesful_transaction_count
  #   joins(:transactions).where(transactions: {result: "success"}).count
  # end

  def full_name
    "#{first_name} #{last_name}"
  end
end