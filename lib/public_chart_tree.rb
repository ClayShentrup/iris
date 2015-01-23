require 'active_support/core_ext/string/inflections'
require 'public_chart_tree/define_node'

# Establishes a DSL for specifiying our public data chart hierarchy
class PublicChartTree
  class PublicChartNotFoundError < StandardError; end

  def initialize(&definition)
    @node_map = {}
    DefineNode.call(RootNode, @node_map, definition)
  end

  def find(identifier)
    @node_map.fetch(identifier)
  rescue KeyError
    raise PublicChartNotFoundError
  end

  # Provides a degenerative case for recursive breadcrumb definition.
  module RootNode
    class << self
      def id_components
        []
      end

      def build_breadcrumb(_node)
        []
      end
    end
  end
end
