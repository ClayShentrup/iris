class PublicChartsTree
  # Provides a degenerative case for recursive breadcrumb definition.
  module RootNode
    class << self
      def id_components
        []
      end

      def breadcrumb
        []
      end

      def title
        'Metrics'
      end

      def value_dimension_manager
        nil
      end
    end
  end
end
