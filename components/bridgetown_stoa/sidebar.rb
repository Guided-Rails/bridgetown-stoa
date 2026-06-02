# frozen_string_literal: true

class BridgetownStoa::Sidebar < Bridgetown::Component
  Node = Struct.new(:title, :url, :order, :parent_title, :current, :children, keyword_init: true)

  def initialize(site:, current_resource:)
    super()
    @site = site
    @current_resource = current_resource
  end

  def tree
    @tree ||= build_tree
  end

  def section_open?(node)
    return true if node.current

    node.children.any? { |child| section_open?(child) }
  end

  private

  def navigable_resources
    @site.resources.select do |r|
      next false if r.data[:nav_exclude]
      next false unless r.data[:title]
      next false unless r.output_ext == ".html"

      true
    end
  end

  def build_tree
    nodes = navigable_resources.map { |r| build_node(r) }
    by_title = nodes.to_h { |n| [n.title, n] }

    roots = nodes.each_with_object([]) do |node, acc|
      parent = node.parent_title && by_title[node.parent_title]
      if parent && parent != node
        parent.children << node
      else
        acc << node
      end
    end

    sort_nodes!(roots)
    roots
  end

  def build_node(resource)
    Node.new(
      title: resource.data[:title],
      url: resource.relative_url,
      order: resource.data[:nav_order],
      parent_title: resource.data[:parent],
      current: resource == @current_resource,
      children: []
    )
  end

  def sort_nodes!(nodes)
    nodes.sort_by! { |n| [n.order || Float::INFINITY, n.title.to_s.downcase] }
    nodes.each { |n| sort_nodes!(n.children) }
  end
end
