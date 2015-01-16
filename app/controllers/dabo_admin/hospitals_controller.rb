# Dabo Admin Hospitals Controller
class DaboAdmin::HospitalsController < ApplicationController
  def model_params
    params.require(:hospital)
      .permit(:name, :provider_id, :city, :state, :hospital_system_id)
  end
end
