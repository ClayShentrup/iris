# Handles ajax searches across the app (like autocomplete)
class SearchController < ApplicationController
  def hospitals
    render json: Search::HospitalSearch.call(params.fetch(:term))
  end
end
