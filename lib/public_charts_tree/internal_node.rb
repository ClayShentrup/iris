require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'

# .
class PublicChartsTree
  # A Node creates a consistent interface to ChildNode instances
  # or RootNode .
  InternalNode = Struct.new(:embedded_node) do
    delegate :id,
             :short_title,
             to: :parent, prefix: true
    delegate :breadcrumb,
             :build_breadcrumb,
             :bundle,
             :id_components,
             :long_title,
             :parent,
             :short_title,
             :parent_breadcrumb,
             :value_dimension_manager,
             to: :embedded_node

    BUNDLE_LEVEL_IN_TREE = 1

    def children
      @children ||= []
    end

    def id
      id_components.join('/')
    end

    def search(search_term)
      search_result_node.tap do |search_result_node|
        search_tree_root.search(
          search_term: search_term,
          current_result_node: search_result_node,
        )
      end
    end

    def type
      embedded_node.class.name.demodulize.underscore
    end

    def bundle
      id_components[BUNDLE_LEVEL_IN_TREE] || nil
    end

    private

    def search_tree_root
      @search_tree_root = SearchNode.new(self)
    end

    def search_result_node
      search_tree_root.result_node
    end
  end
end
