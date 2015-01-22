require 'active_support/core_ext/module/delegation'
require_relative 'node'
require_relative 'nested_node'

class PublicChartTree
  # A developer-friendly way to build the static chart tree for public data.
  # See implementation config/initializers/public_charts_tree.
  class DefineNode
    attr_reader :node

    def self.call(*args)
      new(*args).node
    end

    def initialize(root_or_nested_node, node_map, definition_block)
      @node = Node.new(root_or_nested_node)
      @node_map = node_map
      instance_eval(&definition_block) if definition_block
      @node_map[@node.id] = @node
    end

    private

    def create_child_node(short_title, &definition_block)
      child_node = NestedNode.new(
        @node,
        short_title,
      )
      @node.children << self.class.call(
        child_node,
        @node_map,
        definition_block,
      )
    end

    def id_component(id_component)
      @node.id_component = id_component
    end

    def dimensions(*dimensions)
      @node.dimensions = dimensions
    end

    alias_method :measure_source, :create_child_node
    alias_method :bundle, :create_child_node
    alias_method :domain, :create_child_node
    alias_method :category, :create_child_node
    alias_method :measure, :create_child_node
  end
end
