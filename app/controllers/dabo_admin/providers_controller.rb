module DaboAdmin
  # Dabo Admin Providers Controller
  class ProvidersController < ApplicationController
    private

    def model_params
      params.require(:provider)
        .permit(
          :city,
          :hospital_system_id,
          :hospital_type,
          :name,
          :socrata_provider_id,
          :state,
          :zip_code,
        )
    end
  end
end
