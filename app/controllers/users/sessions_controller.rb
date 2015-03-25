module Users
  # Custom user sessions controller
  class SessionsController < Devise::SessionsController
    def new
      last_attempt_handler = Sessions::LastAttemptHandler.new(user_email)
      @is_last_attempt = last_attempt_handler.last_attempt?
      super
      last_attempt_handler.send_reset_password_instructions_if_last_attempt
    end

    def create
      session[:session_email] = user_email
      super
      flash[:notice] = reminder if reminder
    end

    private

    def reminder
      Sessions::PasswordExpirationPresenter.call(current_user, view_context)
    end

    def user_email
      resource_params.fetch(:email, nil)
    end
  end
end
