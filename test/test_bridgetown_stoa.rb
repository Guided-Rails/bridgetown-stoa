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

    it "uses just the site metadata title on the home page" do
      assert_match(%r{<title>\s*My Awesome Site\s*</title>}, @contents)
    end

    it "combines page title with site metadata in the document title" do
      about = File.read(dest_dir("about/index.html"))
      assert_match(%r{<title>\s*About\s*\|\s*My Awesome Site\s*</title>}, about)
    end

    it "renders a self-contained HTML document" do
      assert_match(%r{<!doctype html>}i, @contents)
      assert_match(%r{<html[\s>]}, @contents)
      assert_match(%r{<head[\s>]}, @contents)
      assert_match(%r{<body[\s>]}, @contents)
    end

    it "renders semantic chrome around yielded content" do
      assert_match(%r{<header[\s>]}, @contents)
      assert_match(%r{<nav[\s>]}, @contents)
      assert_match(%r{<main[\s>]}, @contents)
      assert_match(%r{<footer[\s>]}, @contents)
      assert_includes @contents, "Testing this plugin."
    end
  end

  describe "sidebar navigation" do # rubocop:disable Metrics/BlockLength
    before do
      @contents = File.read(dest_dir("index.html"))
    end

    it "lists top-level pages as sidebar links" do
      assert_match(%r{<a [^>]*href="/about/?"[^>]*>\s*About\s*</a>}, @contents)
      assert_match(%r{<a [^>]*href="/getting-started/?"[^>]*>\s*Getting Started\s*</a>}, @contents)
      assert_match(%r{<a [^>]*href="/advanced/?"[^>]*>\s*Advanced\s*</a>}, @contents)
    end

    it "orders pages by nav_order, then unordered pages alphabetically" do
      positions = ["Getting Started", "Advanced", ">About<", ">Index<"].map do |needle|
        @contents.index(needle)
      end
      assert positions.none?(&:nil?), "missing sidebar entry: #{positions.inspect}"
      assert_equal positions, positions.sort, "sidebar order wrong: #{positions.inspect}"
    end

    it "nests child pages under their declared parent" do
      assert_match(
        %r{Getting Started\s*</a>.*?<ul>.*?Install.*?Configure.*?</ul>}m,
        @contents
      )
    end

    it "wraps parent sections in <details> with the current section open" do
      install_html = File.read(dest_dir("getting-started/install/index.html"))
      pattern = %r{
        Getting\sStarted\s*</a>\s*
        <details\s+open[^>]*>.*?
        <summary[^>]*></summary>.*?
        Install.*?
        </details>
      }mx
      assert_match(pattern, install_html)
    end

    it "leaves non-current sections collapsed by default" do
      assert_match(
        %r{Getting Started\s*</a>\s*<details(\s[^>]*)?>\s*<summary[^>]*></summary>}m,
        @contents
      )
      refute_match(%r{Getting Started\s*</a>\s*<details\s+open}, @contents)
    end

    it "keeps the parent link and the toggle as siblings (no nested interactive controls)" do
      refute_match(%r{<summary[^>]*>\s*<a[\s>]}, @contents)
    end

    it "sorts children by nav_order" do
      install_pos = @contents.index(">Install<")
      configure_pos = @contents.index(">Configure<")
      assert install_pos && configure_pos
      assert install_pos < configure_pos
    end

    it "omits pages marked nav_exclude" do
      refute_match(%r{>Hidden<}, @contents)
    end

    it "marks the current page with aria-current" do
      gs_html = File.read(dest_dir("getting-started/index.html"))
      assert_match(
        %r{href="/getting-started/?"[^>]*aria-current="page"[^>]*>\s*Getting Started\s*</a>},
        gs_html
      )
    end
  end
end
