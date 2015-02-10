module DaboAdmin
  # Ensure user authenticated as admin before accessing /dabo_admin/flip
  class FeaturesController < Flip::FeaturesController
    before_action EnsureAdminFilter
  end
end
