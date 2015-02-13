# Handles ajax searches across the app (like autocomplete)
class SearchController < ApplicationController
  def hospitals
    render json: Search::HospitalSearch.call(params[:q])
  end
end
