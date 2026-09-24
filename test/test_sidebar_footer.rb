# frozen_string_literal: true

require_relative "helper"

class TestSidebarFooter < Bridgetown::TestCase
  SHADOW_DIR = File.join(SOURCE_DIR, "_components")
  SHADOW_PATH = File.join(SHADOW_DIR, "bridgetown_stoa/sidebar_footer.serb")

  describe "sidebar footer" do
    it "renders the default attribution inside the sidebar" do
      contents = File.read(dest_dir("index.html"))
      pattern = %r{
        <aside[^>]*>.*
        <footer\sclass="stoa-sidebar-footer">.*Built\swith.*Bridgetown.*Stoa.*</footer>.*
        </aside>
      }mx
      assert_match(pattern, contents)
    end

    it "can be shadowed by a template in the host site's components directory" do
      with_shadowed_footer("<footer class=\"custom-footer\">A Guided Rails project.</footer>") do
        contents = File.read(dest_dir("index.html"))
        assert_match(%r{<footer class="custom-footer">A Guided Rails project\.</footer>}, contents)
        refute_includes contents, "Built with"
      end
    end
  end

  private

  def with_shadowed_footer(markup)
    FileUtils.mkdir_p(File.dirname(SHADOW_PATH))
    File.write(SHADOW_PATH, markup)
    rebuild_site
    yield
  ensure
    FileUtils.rm_rf(SHADOW_DIR)
    rebuild_site
  end

  # Bridgetown memoizes a component's template on the class, so a template
  # added after the first build is only picked up once that cache is cleared.
  def rebuild_site
    %i(@_tmpl_path @_tmpl_content @_tmpl).each do |ivar|
      next unless BridgetownStoa::SidebarFooter.instance_variable_defined?(ivar)

      BridgetownStoa::SidebarFooter.remove_instance_variable(ivar)
    end
    with_metadata title: "My Awesome Site" do
      @site.process
    end
  end
end
