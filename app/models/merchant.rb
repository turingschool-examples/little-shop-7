class Merchant < ApplicationRecord
  has_many :items

  validates :name, presence: true

  def toggle_disabled
    update(disabled: !disabled)
  end

  def default_status
    update(status: false)
  end
end
