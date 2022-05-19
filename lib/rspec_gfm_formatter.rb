# frozen_string_literal: true

require "rspec/core/formatters"
require "rspec/core/formatters/base_text_formatter"
require "rspec/core/formatters/helpers"

class RspecGfmFormatter < ::RSpec::Core::Formatters::BaseTextFormatter
  ::RSpec::Core::Formatters.register self,:start, :dump_failures, :dump_pending, :dump_summary, :seed, :close

  def initialize(output)
    super
    @running_in_github_actions = ENV.fetch("GITHUB_ACTIONS", "false") == "true"
  end

  def start(start_notification)
    @example_count = start_notification.count
  end

  def dump_summary(summary_notification)
    @summary = summary_notification
  end

  def dump_failures(examples_notification)
    @failures = examples_notification
  end

  def dump_pending(examples_notification)
    @pending = examples_notification
  end

  def seed(seed_notification)
    @seed = seed_notification.seed
  end

  def close(null_notification)
    output.write <<~MD
      # 🚧 Test suite results

      Finished in #{@summary.formatted_duration} (files took #{@summary.formatted_load_time} to load).

      #{@summary.totals_line}
    MD
    create_table_from_summary

    add_failures

    add_pending

    footer
  end

  private

  def create_table_from_summary
    return unless @summary

    output.write <<~MD

      | 🧪 Example | ❔ Passed  | ⏱ Time (s) |
      | --------- | --------- | --------- |
    MD

    @summary.examples.each do |example|
      unless example.skipped?
        output.write "| #{example.full_description} | #{status(example.execution_result.status)} " +
                       " | #{example.execution_result.run_time} |\n"
      end
    end
  end

  def add_failures
    unless @failures.failure_notifications.size.zero?
      output.write <<~MD

        
        ## Failed examples

      MD

      @failures.failure_notifications.each do |notification|
        output.write <<~MD
          1. #{notification.example.full_description}:
             #{linkify_file_in_md(notification.example.location)}
        MD
        if notification.example.display_exception
          output.write <<MD
   ```
   #{notification.example.display_exception}
   #{notification.example.display_exception.backtrace}
   ```
MD
        end
        output.write "\n"
      end
    end
  end

  def add_pending
    unless @pending.pending_notifications.size.zero?
      output.write <<~MD
        ## Pending
  
        Failures listed here are expected and do not affect your suite's status.

      MD

      @pending.pending_notifications.each do |notification|
        output.write <<~MD
          1. #{notification.example.full_description}: #{linkify_file_in_md(notification.example.location)}
        MD
      end
    end
  end

  def footer

  end

  def duration(seconds)
    RSpec::Core::Formatters::Helpers.format_duration(seconds)
  end

  def status(status)
    case status
    when :failed
      "❌ Failed"
    when :passed
      "☑️ Passed"
    end
  end

  def gh?
    @running_in_github_actions
  end

  def linkify_file_in_md(example_location)
    if gh?
      filepath, line = example_location.split(":")
      urlpath = filepath.gsub(/\A\.\//, "")
      "[`#{filepath}:#{line}`](#{repo}/blob/#{sha}/#{urlpath}#L#{line})"
    else
      "`#{example_location}`"
    end
  end

  def repo
    "https://github.com/#{ENV.fetch("GITHUB_REPOSITORY")}"
  end

  def sha
    ENV.fetch("GITHUB_SHA")
  end
end
