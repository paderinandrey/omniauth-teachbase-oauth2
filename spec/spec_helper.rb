# frozen_string_literal: true

require 'bundler/setup'
require 'webmock/rspec'
require 'simplecov'

SimpleCov.start do
  add_filter 'spec/'
  add_filter 'vendor/'
end

require 'omniauth-teachbase-oauth2'

OmniAuth.config.logger = Logger.new('/dev/null')

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'

  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
