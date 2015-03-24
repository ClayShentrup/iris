require 'active_support/core_ext/string/inflections'
require 'public_charts_tree/define_node'
require 'public_charts_tree/root_node'
require 'public_charts_tree/node'
require 'public_charts_tree/search_node'

# Establishes a DSL for specifiying our public data chart hierarchy
class PublicChartsTree
  class PublicChartNotFoundError < StandardError; end

  def initialize(&definition)
    @internal_node_map = {}
    DefineNode.call(RootNode, @internal_node_map, definition)
  end

  def find_node(node_id, providers:)
    Node.new(
      find_internal_node(node_id),
      providers: providers,
    )
  rescue KeyError
    raise PublicChartNotFoundError
  end

  def import_all
    dimension_sample_managers.each(&:import)
  end

  private

  def find_internal_node(node_id)
    @internal_node_map.fetch(node_id)
  end

  def dimension_sample_managers
    all_nodes.map(&:value_dimension_manager).compact
  end

  def all_nodes
    @internal_node_map.values
  end
end
