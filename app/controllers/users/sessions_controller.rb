module Users
  # Custom user sessions controller
  class SessionsController < Devise::SessionsController
    def new
      @sessions_presenter = SessionsPresenter.new(params, flash)
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
