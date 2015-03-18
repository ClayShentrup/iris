# Handles ajax searches across the app (like autocomplete)
class ProviderSearchResultsController < ApplicationController
  layout false

  def index
    @providers = Provider.search_results(params.fetch(:term))
  end
end
