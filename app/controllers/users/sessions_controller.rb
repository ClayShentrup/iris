module Users
  # Custom user sessions controller
  class SessionsController < Devise::SessionsController
    def new
      @sessions_presenter = Sessions::SecondLoginAttemptPresenter.new(
        params, flash
      )
      @sessions_presenter.send_reset_password_email_if_last_attempt
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
  end
end
