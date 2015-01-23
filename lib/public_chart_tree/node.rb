# .
class PublicChartTree
  # A Node creates a consistent interface to NestedNode instances
  # or RootNode .
  Node = Struct.new(:embedded_node) do
    attr_reader :children
    delegate :id, to: :parent, prefix: true
    delegate :build_breadcrumb,
             :dimensions,
             :id_components,
             :parent,
             to: :embedded_node

    def initialize(embedded_node)
      super
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

    def detail_chart?
      embedded_node.is_detail_chart
    end
  end
end
