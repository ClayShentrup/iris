# .
class PublicChartTree
  # A Node creates a consistent interface to NestedNode instances
  # or RootNode .
  Node = Struct.new(:embedded_node) do
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

    def measure?
      embedded_node.is_measure
    end

    def parent_is_root?
      parent_id.blank?
    end
  end
end
