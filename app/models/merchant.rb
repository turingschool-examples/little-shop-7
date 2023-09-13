class Merchant < ApplicationRecord
  has_many :items

  validates :name, presence: true

  def toggle_disabled
    update(disabled: !disabled)
  end
end
