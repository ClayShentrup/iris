# Controller for autocomplete measures search
class MeasureSearchResultsController < ApplicationController
  def index
    ms = PUBLIC_CHARTS_TREE.find_node(
      'public-data',
      providers: provider_subset,
    )
    term = params.fetch(:term)
    results = ms.search(term)
    render partial: 'metric_module',
           collection: results.children,
           locals: { term: term }
  end

  private

  def provider_subset
    Provider.first(5)
  end
end
