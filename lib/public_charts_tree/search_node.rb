# .
class PublicChartsTree
  # Extends a Node with search functionality
  class SearchNode < SimpleDelegator
    def match?(search_term)
      title =~ /#{search_term}/i
    end

    def search(search_term:, current_result_node:)
      children.each do |child|
        result_node = child.result_node
        child.search(
          current_result_node: result_node,
          search_term: search_term,
        )
        next unless child.match?(search_term) or result_node.children.any?
        current_result_node.children << result_node
      end
    end

    def result_node
      SearchResultNode.new(self)
    end

    private

    def children
      @children ||= __getobj__.children.map { |child| self.class.new(child) }
    end
  end
end
