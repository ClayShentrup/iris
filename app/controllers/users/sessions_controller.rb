module Users
  # Custom user sessions controller
  class SessionsController < Devise::SessionsController
    def new
      @sessions_presenter = SessionsPresenter.new(params, flash)
      super
    end
  end
end
