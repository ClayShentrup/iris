module DaboAdmin
  # Controller for Users CRUD
  class UsersController < ApplicationController
    before_action EnsureAdminFilter

    private

    def model_params
      model_params =
        params.require(:user).permit(:email, :is_dabo_admin, :password)

      exclude_blank_password_param(model_params)
    end

    def exclude_blank_password_param(params)
      params.delete(:password) if params.fetch(:password, nil).blank?
      params
    end
  end
end
