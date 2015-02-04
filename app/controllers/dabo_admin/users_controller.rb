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
      params.tap { |p| p.delete(:password) if p.fetch(:password).blank? }
    end
  end
end
