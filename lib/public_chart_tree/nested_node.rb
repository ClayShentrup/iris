# A NestedNode instance represents any node below the root.
class PublicChartTree
  NestedNode = Struct.new(:parent, :short_title) do
    attr_writer :id_component
    attr_accessor :dimensions

    def breadcrumbs
      parent.breadcrumbs + [short_title]
    end

    def id_components
      parent.id_components + [id_component]
    end

    private

    def id_component
      @id_component || short_title.parameterize
    end
  end
end
