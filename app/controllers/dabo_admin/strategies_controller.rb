module DaboAdmin
  # Ensure user authenticated as admin before accessing /dabo_admin/flip
  class StrategiesController < Flip::StrategiesController
    before_action EnsureAdminFilter
  end
end
