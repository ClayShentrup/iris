# .
class PublicChartTree
  # Delegates methods to a PublicChartTree InternalNode, for use outside of
  # PublicChartTree. Prevents us from unnecessarily exposing InternalNode
  # methods outside of PublicChartTree.
  Node = Struct.new(:internal_node) do
    delegate :id,
             :search,
             :parent_is_root?,
             :short_title,
             :long_title,
             :parent_id,
             :breadcrumb,
             :parent_breadcrumb,
             :parent_short_title,
             :type,
             to: :internal_node

    def breadcrumbs
      parent_breadcrumb + breadcrumb
    end

    def children
      internal_node.children.map do |child_internal_node|
        Node.new(child_internal_node)
      end
    end
  end
end
