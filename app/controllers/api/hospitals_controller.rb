class Api::HospitalsController < ApplicationController
  def index
    q = params[:q]

    @hospitals =
      if q.present?
        Hospital.where("LOWER(name) LIKE :name", name: "#{q.downcase}%")
      else
        Hospital.all
      end

    respond_to do |format|
      format.json { render json: @hospitals }
    end
  end
end
