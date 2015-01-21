class PublicChartTree
  # A developer-friendly way to build the static chart tree for public data.
  # See implementation config/initializers/public_charts_tree.rb
  class NodeCreator
    attr_reader :node

    Node = Struct.new(:children, :short_name, :dimensions, :path)

    def self.call(*args)
      new(*args).node
    end

    def initialize(path_components, short_name, node_map, definition)
      @path_components = path_components
      @node_map = node_map
      @node = Node.new([], short_name)
      instance_eval(&definition) if definition
      @node.path = path
      @node_map[path] = @node
    end

    private

    def path
      @path_components.join('/')
    end

    def create_child_node(short_name, &block)
      child_node = self.class.call(
        @path_components + [short_name.parameterize],
        short_name,
        @node_map,
        block,
      )
      @node.children << child_node
    end

    def path_component(path_component)
      @path_components[-1] = path_component
    end

    def dimensions(*dimensions)
      @node.dimensions = dimensions
    end

    alias_method :measure_source, :create_child_node
    alias_method :bundle, :create_child_node
    alias_method :domain, :create_child_node
    alias_method :category, :create_child_node
    alias_method :measure, :create_child_node
  end
end
