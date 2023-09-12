class Item < ApplicationRecord
  def unit_price_formatted
    unit_price.to_f / 100
  end
end
