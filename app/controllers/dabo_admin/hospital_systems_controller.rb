module DaboAdmin
  # A controller for Hospital Systems Admin Panel
  class HospitalSystemsController < ApplicationController
    before_action EnsureAdminFilter

    private

    def model_params
      params.require(:hospital_system).permit(:name)
    end
  end
end
