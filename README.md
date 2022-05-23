# RSpec GitHub Flavored Markdown Formatter

In May 2022, GitHub [announced "Supercharging GitHub Actions with Job Summaries"](https://github.blog/2022-05-09-supercharging-github-actions-with-job-summaries/). RSpec GitHub Flavored Markdown Formatter is a gem specifically created for GitHub Actions Job Summaries. It produces a [GitHub Flavored Markdown](https://github.github.com/gfm/) output for your RSpec tests and outputs it wherever you desire.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec_gfm_formatter', group: :test
```

And then execute:

```shell
$ bundle install
```

Or, alternatively:

```shell
$ bundle add rspec_gfm_formatter --group "test"
```

## Usage

Add the formatter to GitHub Actions workflow file:

    - name: Run tests
      run: |
        bundle exec rspec --format RspecGfmFormatter >> $GITHUB_STEP_SUMMARY

Obviously you can use it outside of GitHub Actions and produce Markdown files compatible with GitHub.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `rspec_gfm_formatter.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Holek/rspec_gfm_formatter.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
