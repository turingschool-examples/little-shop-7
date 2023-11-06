# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'simplecov'
SimpleCov.start
require 'support/faker'
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
# Add additional requires below this line. Rails is not loaded until this point!


def test_data
  @customer1 = create(:customer)
  @customer2 = create(:customer)
  @customer3 = create(:customer)
  @customer4 = create(:customer)
  @customer5 = create(:customer)

  @test_customers = [@customer1, @customer2, @customer3, @customer4, @customer5]

  count = 25
  @test_customers.each do |customer|
    invoices = []
    count.times do
      invoices << create(:invoice, customer_id: customer.id)
    end
    invoices = invoices.map{|i| i.id}
    invoices.each{|id| create(:transaction, result: 1, invoice_id: id)}
    count-=1
  end

  @item1 = create(:item)
  @item2 = create(:item)
  @item3 = create(:item)
  @item4 = create(:item)
  @item5 = create(:item)

  @incomplete = create(:invoice, customer_id: @customer5.id, status: 0, created_at: Time.new(2021, 3, 9))
  @incomplete2 = create(:invoice, customer_id: @customer5.id, status: 0, created_at: Time.new(2021, 12, 5))
  @incomplete3 = create(:invoice, customer_id: @customer5.id, status: 0, created_at: Time.new(2021, 2, 4))
  @completed = create(:invoice, customer_id: @customer5.id, status: 1, created_at: Time.new(2021, 2, 4))
  @cancelled = create(:invoice, customer_id: @customer5.id, status: 2, created_at: Time.new(2021, 2, 4))

  @incomplete_results = [@incomplete, @incomplete2, @incomplete3]

  create(:invoice_item, item_id: @item1.id, invoice_id: @incomplete.id, status: 2)
  create(:invoice_item, item_id: @item2.id, invoice_id: @incomplete.id, status: 2)
  create(:invoice_item, item_id: @item3.id, invoice_id: @incomplete.id, status: 1)

  create(:invoice_item, item_id: @item1.id, invoice_id: @incomplete2.id, status: 0)
  create(:invoice_item, item_id: @item2.id, invoice_id: @incomplete2.id, status: 1)
  create(:invoice_item, item_id: @item3.id, invoice_id: @incomplete2.id, status: 0)

  create(:invoice_item, item_id: @item4.id, invoice_id: @incomplete3.id, status: 0)
end

def test_data_2
  @merchant1 = create(:merchant, name: "Target")

  @customer1 = create(:customer)
  @customer2 = create(:customer)
  @customer3 = create(:customer)

  @item1 = create(:item, name: "hat", description: "cool hat", unit_price: 10, merchant_id: @merchant1.id)
  @item2 = create(:item, name: "straw", description: "it is for drinking", unit_price: 1, merchant_id: @merchant1.id)
  @item3 = create(:item, name: "phone", description: "retro phone", unit_price: 100, merchant_id: @merchant1.id)
  @item4 = create(:item, name: "bike", description: "mountain bike", unit_price: 10000, merchant_id: @merchant1.id)
  @item5 = create(:item, name: "goggles", description: "wear it snowboard", unit_price: 80, merchant_id: @merchant1.id)
  @item6 = create(:item, name: "hairspray", description: "get that hair stiff", unit_price: 8, merchant_id: @merchant1.id)
  @item7 = create(:item, name: "mug", description: "drink tea out of it", unit_price: 5, merchant_id: @merchant1.id)
  @item8 = create(:item, name: "candy", description: "get that sugar up", unit_price: 3, merchant_id: @merchant1.id)
  
  @invoice1 = create(:invoice, status: 1, customer_id: @customer1.id, created_at: Time.new(2023, 1, 1)) #sunday
  @invoice2 = create(:invoice, status: 1, customer_id: @customer2.id, created_at: Time.new(2022, 2, 1)) #Tuesday
  @invoice3 = create(:invoice, status: 1, customer_id: @customer3.id, created_at: Time.new(2021, 3, 1)) #Monday
  
  @invoice_item1 = InvoiceItem.create(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 4, unit_price: 10, status: 2)
  @invoice_item2 = InvoiceItem.create(item_id: @item2.id, invoice_id: @invoice1.id, quantity: 1000, unit_price: 1, status: 2)
  @invoice_item3 = InvoiceItem.create(item_id: @item3.id, invoice_id: @invoice1.id, quantity: 202, unit_price: 100, status: 2)
  @invoice_item4 = InvoiceItem.create(item_id: @item4.id, invoice_id: @invoice1.id, quantity: 2, unit_price: 10000, status: 2)
  @invoice_item6 = InvoiceItem.create(item_id: @item6.id, invoice_id: @invoice1.id, quantity: 4, unit_price: 8, status: 2)
  @invoice_item5 = InvoiceItem.create(item_id: @item7.id, invoice_id: @invoice3.id, quantity: 400, unit_price: 5, status: 2)
  @invoice_item7 = InvoiceItem.create(item_id: @item7.id, invoice_id: @invoice1.id, quantity: 5, unit_price: 5, status: 2)
  @invoice_item8 = InvoiceItem.create(item_id: @item8.id, invoice_id: @invoice1.id, quantity: 40, unit_price: 3, status: 2)
  @invoice_item9 = InvoiceItem.create(item_id: @item8.id, invoice_id: @invoice2.id, quantity: 4, unit_price: 10, status: 2)
  @invoice_item10 = InvoiceItem.create(item_id: @item7.id, invoice_id: @invoice2.id, quantity: 40, unit_price: 5, status: 2)
  @invoice_item11 = InvoiceItem.create(item_id: @item6.id, invoice_id: @invoice2.id, quantity: 3, unit_price: 8, status: 2)
  @invoice_item12 = InvoiceItem.create(item_id: @item5.id, invoice_id: @invoice2.id, quantity: 4, unit_price: 80, status: 2)
  @invoice_item13 = InvoiceItem.create(item_id: @item4.id, invoice_id: @invoice2.id, quantity: 1, unit_price: 10000, status: 2)
  @invoice_item14 = InvoiceItem.create(item_id: @item3.id, invoice_id: @invoice3.id, quantity: 40, unit_price: 100, status: 2)
  @invoice_item15 = InvoiceItem.create(item_id: @item2.id, invoice_id: @invoice2.id, quantity: 4000, unit_price: 1, status: 2)
  @invoice_item16 = InvoiceItem.create(item_id: @item1.id, invoice_id: @invoice3.id, quantity: 400, unit_price: 10, status: 2)

  @transaction1 = create(:transaction, result: 1, invoice_id: @invoice1.id)
  @transaction2 = create(:transaction, result: 1, invoice_id: @invoice2.id)
  @transaction3 = create(:transaction, result: 1, invoice_id: @invoice3.id)
end

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end