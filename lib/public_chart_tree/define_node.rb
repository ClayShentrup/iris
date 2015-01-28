require 'active_support/core_ext/module/delegation'
require_relative 'node'
require_relative 'nested_node'

# .
class PublicChartTree
  # A developer-friendly way to build the static chart tree for public data.
  # See implementation config/initializers/public_charts_tree.
  DefineNode = Struct.new(:embedded_node, :node_map, :definition_block) do
    def self.call(*args)
      new(*args).call
    end

    def call
      instance_eval(&definition_block) if definition_block
      insert_node_into_tree
      node
    end

    private

    def insert_node_into_tree
      node_map[node.id] = node
    end

    def node
      @node ||= Node.new(embedded_node)
    end

    def create_child_node(short_title, is_measure, definition_block)
      child_node = NestedNode.new(
        node,
        short_title,
        is_measure,
      )
      node.children << self.class.call(
        child_node,
        node_map,
        definition_block,
      )
    end

    def measure(short_title, &definition_block)
      create_child_node(short_title, true, definition_block)
    end

    def non_measure(short_title, &definition_block)
      create_child_node(short_title, false, definition_block)
    end

    def id_component(id_component)
      embedded_node.id_component = id_component
    end

    def dimensions(*dimensions)
      embedded_node.dimensions = dimensions
    end

    alias_method :measure_source, :non_measure
    alias_method :bundle, :non_measure
    alias_method :domain, :non_measure
    alias_method :category, :non_measure
  end
end
