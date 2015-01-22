require 'active_support/core_ext/string/inflections'
require 'public_chart_tree/node_creator'

# Establishes a DSL for specifiying our public data chart hierarchy
class PublicChartTree
  def initialize(&definition)
    @node_map = {}
    DefineNode.call(RootNode, @node_map, definition)
  end

  def find(identifier)
    @node_map.fetch(identifier)
  end

  # Provides a degenerative case for recursive breadcrumb definition.
  module RootNode
    class << self
      def breadcrumbs
        []
      end

      def id_components
        []
      end
    end
  end
end
