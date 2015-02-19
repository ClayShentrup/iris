module DaboAdmin
  # Controller for DaboAdmin Index
  class DaboAdminsController < ApplicationController
    before_action EnsureAdminFilter

    def index
    end
  end
end
