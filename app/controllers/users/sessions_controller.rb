module Users
  # controller to allow custom login flash message.
  class SessionsController < Devise::SessionsController
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
