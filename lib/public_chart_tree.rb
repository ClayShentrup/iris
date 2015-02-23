require 'active_support/core_ext/string/inflections'
require 'public_chart_tree/define_node'
require 'public_chart_tree/root_node'
require 'public_chart_tree/node'
require 'public_chart_tree/search_node'

# Establishes a DSL for specifiying our public data chart hierarchy
class PublicChartTree
  class PublicChartNotFoundError < StandardError; end

  def initialize(&definition)
    @internal_node_map = {}
    DefineNode.call(RootNode, @internal_node_map, definition)
  end

  def find(node_id)
    Node.new(find_internal_node(node_id))
  rescue KeyError
    raise PublicChartNotFoundError
  end

  private

  def find_internal_node(node_id)
    @internal_node_map.fetch(node_id)
  end
end
