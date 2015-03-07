# Handles ajax searches across the app (like autocomplete)
class ProviderSearchResultsController < ApplicationController
  layout false

  def index
    @providers = Provider.search_results(params.fetch(:term))
  end

  def show
    @provider_compare_presenter =
      Providers::ProviderComparePresenter.new(current_provider)
    set_selected_provider_id
  end

  private

  def current_provider
    @current_provider ||= Provider.find(params.require(:id))
  end

  def set_selected_provider_id
    current_user.settings.selected_provider_id = current_provider.id
    current_user.save!
  end
end
