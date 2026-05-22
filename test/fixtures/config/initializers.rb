# frozen_string_literal: true

Bridgetown.configure do |config|
  # require_gem: false because test/helper.rb already loads the gem; without
  # this, Bridgetown's plugin manager calls `install_npm_dependencies` and
  # injects a self-referencing `bridgetown-stoa` dep into the gem's own
  # `package.json` on every test run.
  init :"bridgetown-stoa", require_gem: false
end
