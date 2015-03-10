module Users
  # Custom user sessions controller
  class SessionsController < Devise::SessionsController
    def new
      @reset_password = reset_password?
      @current_user = current_user unless params.fetch(:user, nil).nil?
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

    def current_user
      @current_user ||= User.find_by_email(params.fetch(:user).fetch(:email))
    end

    def reset_password?
      if params.keys.include?('user')
        current_user.failed_attempts == 2
      else
        false
      end
    end
  end
end
