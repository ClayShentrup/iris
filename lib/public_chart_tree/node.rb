# .
class PublicChartTree
  # A Node creates a consistent interface to NestedNode instances
  # or RootNode .
  class Node
    CHART_TYPES = {
      measure_source: :default,
      bundle: :default,
      domain: :default,
      category: :category,
      measure: :measure,
    }

    attr_reader :children
    delegate :id,
             :short_title,
             to: :parent, prefix: true
    delegate :build_breadcrumb,
             :dimensions,
             :long_title,
             :id_components,
             :parent,
             :short_title,
             to: :@embedded_node

    def initialize(embedded_node:)
      @embedded_node = embedded_node
      @children = []
    end

    def id
      id_components.join('/')
    end

    def breadcrumbs
      parent.breadcrumb + breadcrumb
    end

    def breadcrumb
      build_breadcrumb(self)
    end

    def measure?
      @embedded_node.type == :measure
    end

    def parent_is_root?
      parent_id.blank?
    end

    def chart_type
      CHART_TYPES.fetch(@embedded_node.type)
    end
  end
end
