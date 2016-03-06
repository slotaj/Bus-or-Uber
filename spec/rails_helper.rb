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
require 'webmock'


SimpleCov.start "rails"

ActiveRecord::Migration.maintain_test_schema!

OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:uber] = OmniAuth::AuthHash.new({
    provider: 'uber',
    uid: "b7e43c5b-aa83-49fe-8832-9ea85703740a",
    info: {
      first_name: "Justin",
      last_name: "Pease",
      email: 'justinpease2@gmail.com',
      picture: "",
    },
    credentials: {
      token: ENV['uber_test_user_token']
    }
  })


  VCR.configure do |c|
    c.cassette_library_dir = "spec/vcr"
    c.hook_into :webmock
  end

  RSpec.configure do |config|
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = true
    config.infer_spec_type_from_file_location!
    config.filter_rails_from_backtrace!
    config.include Capybara::DSL
    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
    end

    config.around(:each) do |example|
      DatabaseCleaner.cleaning do
        example.run
      end
    end
end
