# frozen_string_literal: true

require_relative "helper"

class TestBridgetownStoa < Bridgetown::TestCase
  def setup
    Bridgetown.reset_configuration!
    @config = Bridgetown.configuration(
      "root_dir"    => root_dir,
      "source"      => source_dir,
      "destination" => dest_dir,
      "quiet"       => true
    )
    @config.run_initializers! context: :static
    @site = Bridgetown::Site.new(@config)

    with_metadata title: "My Awesome Site" do
      @site.process
    end
  end

  describe "BridgetownStoa" do
    before do
      @contents = File.read(dest_dir("index.html"))
    end

    it "combines page title with site metadata in the document title" do
      assert_includes @contents, "<title>Home | My Awesome Site</title>"
    end

    it "renders a self-contained HTML document" do
      assert_match(%r{<!doctype html>}i, @contents)
      assert_includes @contents, "<html"
      assert_includes @contents, "<head>"
      assert_includes @contents, "<body>"
    end

    it "renders semantic chrome around yielded content" do
      assert_includes @contents, "<header"
      assert_includes @contents, "<main"
      assert_includes @contents, "<footer"
      assert_includes @contents, "Testing this plugin."
    end
  end
end
