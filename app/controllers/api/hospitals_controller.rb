class Api::HospitalsController < ApplicationController
  respond_to :json

  before_action ControllerFilters::EnsureJsonRequest

  def index
    q = params.require(:q)

    @hospitals =
      if q.present?
        Hospital.where("LOWER(name) LIKE :name", name: "%#{q.downcase}%")
      else
        Hospital.all
      end
  end
end
