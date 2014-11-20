class Api::HospitalsController < ApplicationController
  def index
    q = params[:q]

    @hospitals = Hospital.where("LOWER(name) LIKE :name", name: "#{q.downcase}%")

    respond_to do |format|
      format.json { render json: @hospitals }
    end
  end
end
