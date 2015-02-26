require 'active_support/core_ext/module/delegation'
require_relative 'internal_node'
require_relative 'child_node'
require_relative 'measure_source'
require_relative 'bundle'
require_relative 'domain'
require_relative 'category'
require_relative 'measure'

# .
class PublicChartsTree
  # A developer-friendly way to build the static chart tree for public data.
  # See implementation config/initializers/public_charts_tree.
  DefineNode = Struct.new(:embedded_node, :node_map, :definition_block) do
    def self.call(*args)
      new(*args).call
    end

    def call
      instance_eval(&definition_block) if definition_block
      insert_internal_node_into_tree
    end

    def insert_internal_node_into_tree
      node_map[internal_node.id] = internal_node
    end

    def internal_node
      @internal_node ||= InternalNode.new(embedded_node)
    end

    def long_title(long_title)
      embedded_node.long_title = long_title
    end

    def value(value_dimension)
      embedded_node.value_dimension = value_dimension
    end

    def measure_source(*args, &definition_block)
      create_child_node(*args, definition_block, MeasureSource)
    end

    def bundle(*args, &definition_block)
      create_child_node(*args, definition_block, Bundle)
    end

    def domain(*args, &definition_block)
      create_child_node(*args, definition_block, Domain)
    end

    def category(*args, &definition_block)
      create_child_node(*args, definition_block, Category)
    end

    def measure(*args, &definition_block)
      create_child_node(*args, definition_block, Measure)
    end

    def measures(*measures)
      measures.each do |measure_id|
        measure = MEASURES.fetch(measure_id)
        measure(measure.fetch(:short_title)) do
          long_title measure.fetch(:long_title)
        end
      end
    end

    def create_child_node(short_title, definition_block, child_node_class)
      generic_child_node = ChildNode.new(
        parent: internal_node,
        short_title: short_title,
      )
      child_node = child_node_class.new(generic_child_node)
      internal_node.children << self.class.call(
        child_node,
        node_map,
        definition_block,
      )
    end
  end
end
