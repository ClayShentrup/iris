# .
class PublicChartsTree
  # Delegates methods to a PublicChartsTree InternalNode, for use outside of
  # PublicChartsTree. Prevents us from unnecessarily exposing InternalNode
  # methods outside of PublicChartsTree.
  Node = Struct.new(:internal_node, :providers, :bundles) do
    delegate :id,
             :bundle,
             :search,
             :parent_is_root?,
             :short_title,
             :long_title,
             :parent_id,
             :breadcrumb,
             :parent_breadcrumb,
             :parent_short_title,
             :type,
             :value_dimension_manager,
             :id_components,
             to: :internal_node

    def initialize(internal_node, providers:, bundles:)
      super(internal_node, providers, bundles)
    end

    def breadcrumbs
      parent_breadcrumb + breadcrumb
    end

    def children
      results = internal_node.children.map do |child_internal_node|
        Node.new(child_internal_node, providers: providers, bundles: bundles)
      end

      results.select { |node| above_bundle?(node) || allowed?(node) }
    end

    def above_bundle?(node)
      node.bundle.nil?
    end

    def allowed?(node)
      bundles.include?(node.bundle)
    end

    def data
      {
        bars: bars(providers),
      }
    end

    def bars(providers)
      return [] unless value_dimension_manager.present? # temporary until done
      value_dimension_manager.data(providers).map do |value|
        {
          value: value,
        }
      end
    end

    def parent
      Node.new(internal_node.parent, providers: providers, bundles: bundles)
    end

    private :breadcrumb,
            :parent_breadcrumb,
            :value_dimension_manager,
            :id_components
  end
end
