module ApplicationHelper
  def format_price(price)
    number_to_currency(price, unit: "$", separator: ".", delimiter: "")
  end

  def formatted_time
    to_datetime.strftime("%A, %B %d, %Y")
  end
end
