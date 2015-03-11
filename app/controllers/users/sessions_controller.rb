module Users
  # Custom user sessions controller
  class SessionsController < Devise::SessionsController
    def new
      @password_errors = {
        reset_password_message: reset_password_message?,
        css_class: css_class,
      }
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

    def reset_password_message?
      if valid_user?
        current_user.failed_attempts == 2
      else
        false
      end
    end

    def css_class
      'field_with_errors' if flash.alert &&
                             flash.alert.include?('Invalid email or password')
    end

    def current_user
      User.find_by_email(user_email)
    end

    def valid_user?
      params.keys.include?('user') && current_user
    end

    def user_email
      params.fetch(:user).fetch(:email)
    end
  end
end
