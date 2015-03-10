module Users
  # Custom user sessions controller
  class SessionsController < Devise::SessionsController
    def new
      @reset_password = reset_password?
      super
    end

    def create
      super
      flash[:notice] = reminder if reminder
    end

    private

    def reminder
      Sessions::PasswordExpirationPresenter.call(current_user, view_context)
    end

    def reset_password?
      if user_available?
        current_user.failed_attempts == 2
      else
        false
      end
    end

    def current_user
      User.find_by_email(user_email)
    end

    def user_available?
      params.keys.include?('user') && current_user
    end

    def user_email
      params.fetch(:user).fetch(:email)
    end
  end
end
