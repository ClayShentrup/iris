# Provides methods that determine what styles and partials to render in the
# Sessions#new view
module Sessions
  SecondLoginAttemptPresenter = Struct.new(:params, :flash) do
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

    def user_email
      params.fetch('user').fetch('email')
    end

    def send_reset_password_email_if_last_attempt
      current_user.send_reset_password_instructions if reset_password_message?
    end

    private

    def valid_user?
      params.keys.include?('user') && current_user
    end

    def current_user
      User.find_by_email(user_email)
    end
  end
end
