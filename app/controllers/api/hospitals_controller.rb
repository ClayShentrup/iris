class Api::HospitalsController < ApplicationController
  respond_to :json

  before_action ControllerFilters::EnsureJsonRequest

  def index
    @hospitals = Hospital.search(query)
  end

  def query
    params.permit(:q).fetch(:q, nil)
  end
end
