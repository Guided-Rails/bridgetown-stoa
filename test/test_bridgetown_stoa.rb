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
      assert_match(%r{<main[\s>]}, @contents)
      assert_match(%r{<footer[\s>]}, @contents)
      assert_includes @contents, "Testing this plugin."
    end
  end
end
