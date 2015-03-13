# Provides methods that determine what styles and partials to render in the
# Sessions#new view
module Sessions
  SecondLoginAttemptPresenter = Struct.new(:user, :flash) do
    def reset_password_message?
      if valid_user?
        user_record.failed_attempts == 2
      else
        false
      end
    end

    def css_class
      'field_with_errors' if flash.alert &&
                             flash.alert.include?('Invalid email or password')
    end

    def user_email
      user.fetch('email')
    end

    def user_record
      User.find_by_email(user_email)
    end

    private

    def valid_user?
      true if user && user_record
    end
  end
end
