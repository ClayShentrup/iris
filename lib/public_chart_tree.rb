require 'active_support/core_ext/string/inflections'
require 'public_chart_tree/define_node'
require 'public_chart_tree/root_node'

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
end
