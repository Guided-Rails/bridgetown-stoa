# frozen_string_literal: true

# The attribution footer at the bottom of the sidebar. Rendered by the
# bridgetown-stoa/layout template. Shadow it in a host site at
# src/_components/bridgetown_stoa/sidebar_footer.serb to change the footer
# without copying the whole layout.
class BridgetownStoa::SidebarFooter < Bridgetown::Component
  extend BridgetownStoa::Shadowable
end
