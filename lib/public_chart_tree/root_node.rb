class PublicChartTree
  # Provides a degenerative case for recursive breadcrumb definition.
  module RootNode
    class << self
      def id_components
        []
      end

      def breadcrumb
        []
      end

      def short_title
        'Metrics'
      end
    end
  end
end
