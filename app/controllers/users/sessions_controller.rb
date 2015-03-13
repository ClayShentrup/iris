module Users
  # Custom user sessions controller
  class SessionsController < Devise::SessionsController
    def new
      @sessions_presenter = Sessions::SecondLoginAttemptPresenter.new(
        user, flash
      )
      send_reset_password_email if @sessions_presenter.reset_password_message?
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

    def user
      params.fetch('user', nil)
    end

    def send_reset_password_email
      @sessions_presenter.user_record.send_reset_password_instructions
    end
  end
end
