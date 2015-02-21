class PublicChartTree
  # Provides a degenerative case for recursive breadcrumb definition.
  module RootNode
    class << self
      def id_components
        []
      end

      def build_breadcrumb(_node)
        []
      end
    end
  end
end
