# frozen_string_literal: true

# Lets a host site override a Stoa component's template without redefining
# its Ruby class. Bridgetown normally looks for a component's template next
# to the file that defines the class, which for a gem-provided component is
# inside the gem. Extending a component with this module makes it look in the
# site's own components directory first (for example
# src/_components/bridgetown_stoa/sidebar_footer.serb) and only then fall back
# to the template shipped with the gem.
module BridgetownStoa::Shadowable
  using Bridgetown::Refinements

  def component_template_path
    @_tmpl_path ||= site_template_path || super
  end

  private

  def site_template_path
    site = Bridgetown::Current.site
    return unless site

    relative_name = name.underscore
    site.config.components_load_paths.reverse_each do |load_path|
      supported_template_extensions.each do |ext|
        candidate = File.join(load_path, "#{relative_name}.#{ext}")
        return candidate if File.exist?(candidate)
      end
    end

    nil
  end
end
