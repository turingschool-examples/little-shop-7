require 'csv'

namespace :csv_load do
  desc "TODO"
  task customers: :environment do
    contents = CSV.open "db/data/customers.csv", headers: true, header_converters: :symbol
    
    contents.map do |customer|
      id = customer[:id].to_i
      first_name = customer[:first_name]
      last_name = customer[:last_name]
      created_at = customer[:created_at]
      updated_at = customer[:updated_at]
      
      Customer.create!(id: id, first_name: first_name, last_name: last_name, created_at: created_at, updated_at: updated_at)
    end
    
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE customers_id_seq RESTART WITH #{Customer.maximum(:id).to_i+1}")
  end

  desc "TODO"
  task merchants: :environment do
    contents = CSV.open "db/data/merchants.csv", headers: true, header_converters: :symbol
  
    contents.map do |merchant|
      id = merchant[:id].to_i
      name = merchant[:name]
      created_at = merchant[:created_at]
      updated_at = merchant[:updated_at]
  
      Merchant.create!(id: id, name: name, created_at: created_at, updated_at: updated_at)
    end
  
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE merchants_id_seq RESTART WITH #{Merchant.maximum(:id).to_i+1}")
  end

  desc "TODO"
  task items: :environment do
    contents = CSV.open "db/data/items.csv", headers: true, header_converters: :symbol

    contents.map do |item|
      id = item[:id].to_i
      name = item[:name]
      description = item[:description]
      unit_price = item[:unit_price].to_i
      merchant_id = item[:merchant_id].to_i
      created_at = item[:created_at]
      updated_at = item[:updated_at]

      Item.create!(id: id, name: name, description: description, unit_price: unit_price, merchant_id: merchant_id, created_at: created_at, updated_at: updated_at)
    end

    ActiveRecord::Base.connection.execute("ALTER SEQUENCE items_id_seq RESTART WITH #{Item.maximum(:id).to_i+1}")
  end

  desc "TODO"
  task invoices: :environment do
    contents = CSV.open "db/data/invoices.csv", headers: true, header_converters: :symbol

    contents.map do |invoice|
      id = invoice[:id].to_i
      customer_id = invoice[:customer_id].to_i
      status = if invoice[:status] == "in progress"
        0
      elsif invoice[:status] == "completed"
        1
      elsif invoice[:status] == "cancelled"
        2
      end
      created_at = invoice[:created_at]
      updated_at = invoice[:updated_at]

      Invoice.create!(id: id, customer_id: customer_id, status: status, created_at: created_at, updated_at: updated_at)
    end

    ActiveRecord::Base.connection.execute("ALTER SEQUENCE invoices_id_seq RESTART WITH #{Invoice.maximum(:id).to_i+1}")
  end  

  desc "TODO"
  task invoice_items: :environment do
    contents = CSV.open "db/data/invoice_items.csv", headers: true, header_converters: :symbol

    contents.map do |invoice_item|
      id = invoice_item[:id].to_i
      item_id = invoice_item[:item_id].to_i
      invoice_id = invoice_item[:invoice_id].to_i
      quantity = invoice_item[:quantity].to_i
      unit_price = invoice_item[:unit_price].to_i
      status = if invoice_item[:status] == "pending"
        0
      elsif invoice_item[:status] == "packaged"
        1
      elsif invoice_item[:status] == "shipped"
        2
      end
      created_at = invoice_item[:created_at]
      updated_at = invoice_item[:updated_at]

      InvoiceItem.create!(id: id, item_id: item_id, invoice_id: invoice_id, quantity: quantity, unit_price: unit_price, status: status, created_at: created_at, updated_at: updated_at)
    end

    ActiveRecord::Base.connection.execute("ALTER SEQUENCE invoice_items_id_seq RESTART WITH #{InvoiceItem.maximum(:id).to_i+1}")
  end

  desc "TODO"
  task transactions: :environment do
    contents = CSV.open "db/data/transactions.csv", headers: true, header_converters: :symbol

    contents.map do |transaction|
      id = transaction[:id].to_i
      invoice_id = transaction[:invoice_id].to_i
      credit_card_number = transaction[:credit_card_number]
      credit_card_expiration_date = transaction[:credit_card_expiration_date]
      result = if transaction[:result] == "failed"
        0
      elsif transaction[:result] == "success"
        1
      end
      created_at = transaction[:created_at]
      updated_at = transaction[:updated_at]

      Transaction.create!(id: id, invoice_id: invoice_id, credit_card_number: credit_card_number, credit_card_expiration_date: credit_card_expiration_date, result: result, created_at: created_at, updated_at: updated_at)
    end

    ActiveRecord::Base.connection.execute("ALTER SEQUENCE transactions_id_seq RESTART WITH #{Transaction.maximum(:id).to_i+1}")
  end

  desc "TODO"
  task all: [:customers, :merchants, :items, :invoices, :invoice_items, :transactions] do
  end

end
