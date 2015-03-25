require './app/models/user'

# Provides methods that determine what styles and partials to render in the
# Sessions#new view
module Sessions
  LastAttemptHandler = Struct.new(:user_email) do
    def last_attempt?
      if @last_attempt
        @last_attempt
      else
        @last_attempt = (failed_login_attempt? and user_exists? and
        user.send(:last_attempt?))
      end
    end

    def send_reset_password_instructions_if_last_attempt
      user.send_reset_password_instructions if last_attempt? && user_exists?
    end

    private

    def failed_login_attempt?
      user_email.present?
    end

    def user_exists?
      user.present?
    end

    def user
      @user ||= User.find_by_email(user_email)
    end
  end
end
