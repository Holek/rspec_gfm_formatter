# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "rspec_gfm_formatter"
  spec.version       = "0.1.0"
  spec.authors       = ["Michał Połtyn"]
  spec.email         = ["michal@poltyn.com"]

  spec.summary       = "RSpec GitHub Flavored Markdown Formatter"
  spec.description   = "RSpec GitHub Flavored Markdown Formatter is a gem specifically created for GitHub Actions Job Summaries. It produces a [GitHub Flavored Markdown](https://github.github.com/gfm/) output for your RSpec tests and outputs it whereever you desire."
  spec.homepage      = "https://github.com/Holek/rspec_gfm_formatter"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/Holek/rspec_gfm_formatter/blob/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rspec-core", "~> 3"

  spec.add_development_dependency "pry"
end
