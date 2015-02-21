require 'active_support/core_ext/object/blank'
# .
class PublicChartTree
  # A Node creates a consistent interface to NestedNode instances
  # or RootNode .
  class InternalNode
    attr_reader :children
    delegate :id,
             :short_title,
             to: :parent, prefix: true
    delegate :build_breadcrumb,
             :dimensions,
             :id_components,
             :long_title,
             :parent,
             :short_title,
             :type,
             :parent_breadcrumb,
             to: :@embedded_node

    def initialize(embedded_node:)
      @embedded_node = embedded_node
      @children = []
    end

    def id
      id_components.join('/')
    end

    def breadcrumb
      build_breadcrumb(self)
    end

    def parent_is_root?
      parent_id.blank?
    end
  end
end
