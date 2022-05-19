# frozen_string_literal: true

require "rspec_gfm_formatter"

require_relative "support/formatter_support"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = "tmp/.rspec_status"

  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include FormatterSupport
end
