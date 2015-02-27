module UserProfiles
  # Controller to show user profile admin page
  class AdminsController < ActionController::Base
    before_action :authenticate_user!
    before_action EnsureAdminFilter
    layout 'application'
  end
end
