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

def test_data_3
  @merchant1 = create(:merchant, name: "CandyLand")
  @customer0 = Customer.create(first_name: "Angus", last_name: "Turing")
  @invoice0 = @customer0.invoices.create(status: 1)
  @invoice7 = @customer0.invoices.create(status: 1)
  @invoice8 = @customer0.invoices.create(status: 1)

  @item2 = @merchant1.items.create(name: "Bat", description: "Bat", unit_price: 200)
  @item3 = @merchant1.items.create(name: "Cat", description: "Cat", unit_price: 300)
  @item4 = @merchant1.items.create(name: "Rat", description: "Rat", unit_price: 400)
  @item8 = @merchant1.items.create(name: "Zat", description: "Zat", unit_price: 500)

  @transaction0 = @invoice0.transactions.create(credit_card_number: 1234, credit_card_expiration_date: 01/11, result: 1)
  @transaction7 = @invoice0.transactions.create(credit_card_number: 1234, credit_card_expiration_date: 01/11, result: 1)
  @transaction8 = @invoice8.transactions.create(credit_card_number: 1234, credit_card_expiration_date: 01/11, result: 1)

  @ii1 = create(:invoice_item, item: @item2, invoice: @invoice0, status: 0)
  @ii2 = create(:invoice_item, item: @item3, invoice: @invoice0, status: 1)
  @ii3 = create(:invoice_item, item: @item4, invoice: @invoice0, status: 2)
  @ii7 = create(:invoice_item, item: @item3, invoice: @invoice0, status: 2)
  @ii8 = create(:invoice_item, item: @item8, invoice: @invoice8, status: 1)

  @invoice0.update(created_at: '1999-01-01 00:00:00')
  @invoice8.update(created_at: '2008-08-08 00:00:00')
  date = Date.today.strftime('%A, %B %d, %Y')
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