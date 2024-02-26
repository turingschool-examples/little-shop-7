class Merchant < ApplicationRecord
   has_many :items
   has_many :invoices, through: :items
   has_many :customers, through: :invoices
   
   validates :name, presence: true
   enum :status, [ "enabled", "disabled"]

   def top_five_customers
      Customer.select("customers.*, count(transactions.id) as count_transactions")
      .joins(:transactions).where(transactions: {result: "success"})
      .group('customers.id')
      .order("count_transactions DESC")
      .limit(5)
   end


   def change_status
      if params[:change_status].present?
      new_status = self.status == 'enabled' ? 'disabled' : 'enabled'
      update(status: new_status)
      end
   end

end