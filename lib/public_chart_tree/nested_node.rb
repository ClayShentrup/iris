# .
class PublicChartTree
  # A NestedNode instance represents any node below the root.
  NestedNode = Struct.new(:parent, :short_title, :is_measure) do
    attr_writer :id_component
    attr_accessor :dimensions, :long_title

    def id_components
      parent.id_components + [id_component]
    end

    def build_breadcrumb(node)
      [node]
    end

    private

    def id_component
      @id_component || short_title.parameterize
    end
  end
end
