class Api::HospitalsController < ApplicationController
  respond_to :json

  before_filter :ensure_json_request

  # Not sure we want it
  def ensure_json_request
    return if params[:format] == "json" || request.headers["Accept"] =~ /json/
    render :nothing => true, :status => 406
  end

  def index
    q = params[:q]

    @hospitals =
      if q.present?
        Hospital.where("LOWER(name) LIKE :name", name: "%#{q.downcase}%")
      else
        Hospital.all
      end
  end
end
