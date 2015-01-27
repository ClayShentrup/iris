module DaboAdmin
  # Controller for Users CRUD
  class UsersController < ApplicationController
    before_action EnsureAdminFilter

    private

    def model_params
      params.require(:user).permit(:email, :is_dabo_admin, :password)
    end
  end
end
