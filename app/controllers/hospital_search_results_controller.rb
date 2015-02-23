# Handles ajax searches across the app (like autocomplete)
class HospitalSearchResultsController < ApplicationController
  def index
    render partial: 'hospital',
           collection: Hospital.search_results(params.fetch(:term))
  end

  def show
    render partial: 'show',
           locals: { hospital: Hospital.find(params.require(:id)) }
  end
end
