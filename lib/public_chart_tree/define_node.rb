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
      @node ||= Node.new(embedded_node: embedded_node)
    end

    def create_child_node(short_title, definition_block, node_type)
      child_node = NestedNode.new(
        node,
        short_title,
        node_type,
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

    def measure_source(*args, &definition_block)
      create_child_node(*args, definition_block, :measure_source)
    end

    def long_title(long_title)
      embedded_node.long_title = long_title
    end

    def bundle(*args, &definition_block)
      create_child_node(*args, definition_block, :bundle)
    end

    def domain(*args, &definition_block)
      create_child_node(*args, definition_block, :domain)
    end

    def category(*args, &definition_block)
      create_child_node(*args, definition_block, :category)
    end

    def measure(*args, &definition_block)
      create_child_node(*args, definition_block, :measure)
    end
  end
end
