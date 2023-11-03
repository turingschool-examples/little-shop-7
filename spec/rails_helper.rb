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

  @incomplete_results = [@incomplete, @incomplete2, @incomplete3]

  create(:invoice_item, item_id: @item1.id, invoice_id: @incomplete.id, status: 0)
  create(:invoice_item, item_id: @item2.id, invoice_id: @incomplete.id, status: 0)
  create(:invoice_item, item_id: @item3.id, invoice_id: @incomplete.id, status: 1)

  create(:invoice_item, item_id: @item1.id, invoice_id: @incomplete2.id, status: 0)
  create(:invoice_item, item_id: @item2.id, invoice_id: @incomplete2.id, status: 1)
  create(:invoice_item, item_id: @item3.id, invoice_id: @incomplete2.id, status: 0)

  create(:invoice_item, item_id: @item4.id, invoice_id: @incomplete3.id, status: 0)
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