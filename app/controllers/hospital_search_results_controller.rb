# Handles ajax searches across the app (like autocomplete)
class HospitalSearchResultsController < ApplicationController
  layout false

  def index
    @hospitals = Hospital.search_results(params.fetch(:term))
  end

  def show
    @hospital_compare_presenter =
      Hospitals::HospitalComparePresenter.new(current_hospital)
  end

  private

  def current_hospital
    Hospital.find(params.require(:id))
  end
end
