# frozen_string_literal: true

require "bridgetown"
require_relative "bridgetown-stoa/version"

# @param config [Bridgetown::Configuration::ConfigurationDSL]
Bridgetown.initializer :"bridgetown-stoa" do |config|
  # Add code here which will run when a site includes
  # `init :"bridgetown-stoa"`
  # in its configuration

  # Add default configuration data:
  config.bridgetown_stoa ||= {}
  config.bridgetown_stoa.my_setting ||= 123

  config.source_manifest(
    origin: BridgetownStoa,
    layouts: File.expand_path("../layouts", __dir__)
  )
end
