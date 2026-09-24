# frozen_string_literal: true

# The test suite loads the gem from test/helper.rb; bin/dev boots this site
# through the bridgetown CLI, so make sure the working-tree copy is loaded.
require_relative "../../../lib/bridgetown-stoa"

Bridgetown.configure do |config|
  init :"bridgetown-stoa", require_gem: false

  # Rebuild under bin/dev when the theme's own layouts change (they live
  # outside this site's src/, so the watcher wouldn't see them otherwise).
  # Fast refresh assumes changed paths are inside src/, so turn it off and
  # let every change do a full (still instant) rebuild.
  config.additional_watch_paths << File.expand_path("../../../layouts", __dir__)
  config.fast_refresh = false
end
