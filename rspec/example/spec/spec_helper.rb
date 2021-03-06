require 'capybara/rspec'
require 'selenium-webdriver'

# :selenium => Selenium driving Firefox
# :selenium_headless => Selenium driving Firefox in a headless configuration
# :selenium_chrome => Selenium driving Chrome
# :selenium_chrome_headless => Selenium driving Chrome in a headless configuration

# Capybara.register_driver :custom_headless_chrome do |app|
#   Capybara::Selenium::Driver.new(app,
#     browser: :chrome,
#     desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(),
#     options: Selenium::WebDriver::Chrome::Options.new(
#       # args: %w(--lang=ja-JP)
#       # args: %w(--headless --disable-gpu --lang=ja-JP)
#     )
#   )
# end

Capybara.register_driver :selenium_jp do |app|
  ff_profile = Selenium::WebDriver::Firefox::Profile.new.tap do |profile|
    profile['intl.accept_languages'] = "ja-JP"
  end

  ff_options = Selenium::WebDriver::Firefox::Options.new(profile: ff_profile)

  ff_options.add_argument('-headless')
  # ff_options.add_argument("window-size=#{CAPYBARA_WINDOW_SIZE.join(',')}"

  Capybara::Selenium::Driver.new(app, browser: :firefox, options: ff_options)
end

RSpec.configure do |config|
  Capybara.default_driver = :selenium_chrome

  config.around(:example) do |example|
    puts "--- start"
    example.run
    puts "--- end"
  end

  # this will only load if at least one test with db is there
  config.when_first_matching_example_defined(:db) do
    puts "<<<< import and initialize DB here"
  end

  config.before(:example) do |example|
    db = example.metadata.fetch(:db, false)
    mail = example.metadata.fetch(:mail, false)

    puts "<< #{example.full_description}"
    puts "  << DB ↑" if db
    puts "  << mail ↑" if mail

    # puts example.methods.sort.to_s
    # :full_description
    # :description
  end

  config.after(:example, :db) do |example|
    puts "  << DB ×"
  end

  config.after(:example, :mail) do |example|
    puts "  << mail ×"
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.disable_monkey_patching!
  config.warnings = true
  config.default_formatter = "doc"
  # config.profile_examples = 10
  # config.order = :random
  # Kernel.srand config.seed
end
