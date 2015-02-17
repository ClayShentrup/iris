# Handles ajax searches across the app (like autocomplete)
class HospitalSearchResultsController < ApplicationController
  def index
    render json: Search::HospitalSearch.call(params.fetch(:term))
  end
end
