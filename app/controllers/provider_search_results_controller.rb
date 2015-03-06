# Handles ajax searches across the app (like autocomplete)
class ProviderSearchResultsController < ApplicationController
  layout false

  def index
    @providers = Provider.search_results(params.fetch(:term))
  end

  def show
    @provider_compare_presenter =
      Providers::ProviderComparePresenter.new(current_provider)
  end

  private

  def current_provider
    Provider.find(params.require(:id))
  end
end
