module DaboAdmin
  # Dabo Admin Hospitals Controller
  class HospitalsController < ApplicationController
    private

    def model_params
      params.require(:hospital)
        .permit(:name, :provider_id, :city, :state, :hospital_system_id)
    end
  end
end
