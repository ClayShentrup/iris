module DaboAdmin
  # Controller for Users CRUD
  class UsersController < ApplicationController
    private

    def model_params
      params.require(:user).permit(
        :first_name,
        :last_name,
        :email,
        :is_dabo_admin,
        :password,
        :locked_at,
        :failed_attempts,
        :account_id,
      )
    end
  end
end
