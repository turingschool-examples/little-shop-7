namespace :csv_load do
  desc "Reset primary key sequences for specified tables"
  task reset_primary_keys: :environment do 
    # Reset primary key for the 'table_name' table
    ActiveRecord::Base.connection.execute("SELECT setval('customers_id_seq', (SELECT MAX(id) FROM customers));")
    ActiveRecord::Base.connection.execute("SELECT setval('invoice_items_id_seq', (SELECT MAX(id) FROM invoice_items));")
    ActiveRecord::Base.connection.execute("SELECT setval('invoices_id_seq', (SELECT MAX(id) FROM invoices));")
    ActiveRecord::Base.connection.execute("SELECT setval('items_id_seq', (SELECT MAX(id) FROM items));")
    ActiveRecord::Base.connection.execute("SELECT setval('merchants_id_seq', (SELECT MAX(id) FROM merchants));")
    ActiveRecord::Base.connection.execute("SELECT setval('transactions_id_seq', (SELECT MAX(id) FROM transactions));")
  end
end
