class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  enum :status, {"disabled" => 0, "enabled" => 1}


  def invoice
  self.invoices.each do |invoice|
    invoice
  end
end

  def invoice_date
    self.invoice.first.creation_date
  end

  def packaged
    return unless invoice_items.includes(:invoice_items).where(status: 1).exists?
    self
  end

  def invoice_id
    invoice_items.pluck(:invoice_id).join
  end

  def self.old_to_new
    joins(:invoices).order('invoices.created_at')
  end

  def button_text
    return "Disable" if status == "enabled"
    "Enable"
  end

  # def enabled?
  #   if status == "enabled"
  #     self.toggle_status
  #     return true
  #   else
  #     self.toggle_status
  #     return false
  #   end
  # end


  def toggle_status
    if self.status == "disabled"
      self.status = "enabled"
    else
      self.status = "disabled"
    end
    self.save
  end
end