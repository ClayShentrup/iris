module DaboAdmin
  # Controller for Users CRUD
  class UsersController < ApplicationController
    private

    def model_params
      params.require(:user).permit(
        :email,
        :is_dabo_admin,
        :password,
        :locked_at,
        :failed_attempts,
      )
    end
  end
end
