# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'

require 'vcr'
require 'database_cleaner'
require 'capybara/rails'
require 'capybara/rspec'
require "simplecov"
require 'factory_girl_rails'

SimpleCov.start "rails"

ActiveRecord::Migration.maintain_test_schema!

OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:instagram] = OmniAuth::AuthHash.new({
    provider: 'instagram',
    uid: "224650346",
    info: {
      name: "Justin Pease",
      nickname: "justinpease1",
      email: 'justinpease2@gmail.com',
      image_url: "https://scontent.cdninstagram.com/t51.2885-19/s150x150/12748419_1752098388353622_1993632129_a.jpg",
      bio: "I love testing APIs",
      website: ""
    },
    credentials: {
      token: ENV['test_instagram_token']
    }
  })

  VCR.configure do |c|
    c.cassette_library_dir = "spec/vcr"
    c.hook_into :webmock
  end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include Capybara::DSL
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end
  config.before(:each) do
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end
end
