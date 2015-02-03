module DaboAdmin
  # Controller for Users CRUD
  class UsersController < ApplicationController
    before_action EnsureAdminFilter

    private

    def model_params
      model_params =
        params.require(:user).permit(:email, :is_dabo_admin, :password)

      prevent_blank_password_from_being_saved(model_params)
    end

    def prevent_blank_password_from_being_saved(params)
      params.delete(:password) if params.fetch(:password, nil).blank?
      params
    end
  end
end
