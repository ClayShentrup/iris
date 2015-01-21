require 'active_support/core_ext/string/inflections'

# Establishes a DSL for specifiying our public data chart hierarchy
class PublicChartTree
  def initialize(&definition)
    @node_map = {}
    NodeCreator.call([], nil, @node_map, definition)
  end

  def find(identifier)
    @node_map.fetch(identifier)
  end
end
