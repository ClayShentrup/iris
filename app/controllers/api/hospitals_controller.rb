class Api::HospitalsController < ApplicationController
  respond_to :json

  before_action ControllerFilters::EnsureJsonRequest

  def index
    @hospitals =
      if query.present?
        Hospital.where("LOWER(name) LIKE :name", name: "%#{query.downcase}%")
      else
        Hospital.all
      end
  end

  def query
    params.permit(:q).fetch(:q, nil)
  end
end
