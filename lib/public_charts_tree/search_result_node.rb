# Search result node.
class PublicChartsTree
  SearchResultNode = Struct.new(:node) do
    delegate :id,
             :title,
             to: :node

    def children
      @children ||= []
    end

    def to_h
      {
        title: title,
        children: children.map(&:to_h),
      }
    end
  end
end
