# Search result node.
class PublicChartTree
  SearchResultNode = Struct.new(:node) do
    delegate :id,
             :short_title,
             to: :node

    def children
      @children ||= []
    end

    def to_h
      {
        short_title: short_title,
        children: children.map(&:to_h),
      }
    end
  end
end
