module ApplicationHelper
  def format_price(price)
    number_to_currency(price, unit: "$", separator: ".", delimiter: "")
  end
end
