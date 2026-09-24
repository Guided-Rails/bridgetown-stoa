# frozen_string_literal: true

source "https://rubygems.org"
gemspec

gem "bridgetown", ENV["BRIDGETOWN_VERSION"] if ENV["BRIDGETOWN_VERSION"]

group :development do
  gem "puma" # Rack server for bin/dev
end

group :test do
  gem "minitest"
  gem "minitest-profile"
  gem "minitest-reporters"
end
