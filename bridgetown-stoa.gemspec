# frozen_string_literal: true

require_relative "lib/bridgetown-stoa/version"

Gem::Specification.new do |spec|
  spec.name          = "bridgetown-stoa"
  spec.version       = BridgetownStoa::VERSION
  spec.author        = "Abdullah Hashim"
  spec.email         = "abdul@hey.com"
  spec.summary       = "A Bridgetown documentation theme inspired by just-the-docs"
  spec.homepage      = "https://github.com/Guided-Rails/bridgetown-stoa"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r!^(test|script|spec|features)/!) }
  spec.test_files    = spec.files.grep(%r!^test/!)
  spec.require_paths = ["lib"]
  # TODO: enable the `npm_add` metadata below once the npm companion is
  # published. While the package is unpublished, Bridgetown's init-time
  # registry lookup 404s loudly during every test run.
  # spec.metadata = {
  #   "npm_add" => "bridgetown-stoa@#{BridgetownStoa::VERSION}",
  # }

  spec.required_ruby_version = ">= 3.2"

  spec.add_dependency "bridgetown", "~> 2.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rubocop-bridgetown", "~> 0.3"
end
