# .
class PublicChartsTree
  # A ChildNode instance represents any node below the root.
  ChildNode = Struct.new(:parent, :short_title) do
    attr_accessor :value_dimension_manager

    attr_accessor :long_title

    delegate :breadcrumb,
             to: :parent,
             prefix: true

    def initialize(parent:, short_title:)
      super(parent, short_title)
    end

    def breadcrumb
      [short_title]
    end

    def id_components
      parent.id_components + id_component
    end

    private

    def id_component
      [short_title.parameterize]
    end
  end
end
