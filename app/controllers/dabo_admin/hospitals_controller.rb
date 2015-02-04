module DaboAdmin
  # Dabo Admin Hospitals Controller
  class HospitalsController < ApplicationController
    before_action EnsureAdminFilter

    private

    def model_params
      params.require(:hospital)
        .permit(
          :city,
          :hospital_system_id,
          :hospital_type,
          :name,
          :provider_id,
          :state,
          :zip_code,
        )
    end
  end
end
