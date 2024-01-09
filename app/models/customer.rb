class Customer < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  has_many :invoices

  def self.top_five
    self.joins(invoices: :transactions)
      .where("transactions.result = ?", 0)
      .select("CONCAT(first_name, ' ', last_name) AS full_name, COUNT(transactions) AS success_count")
      .group("full_name")
      .order("success_count DESC")
      .limit(5)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
