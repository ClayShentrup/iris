require_relative './search_result_node'

# .
class PublicChartsTree
  # Delegates to a child node and adds a type.
  class MeasureSource < SimpleDelegator
  end
end
