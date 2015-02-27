module UserProfiles
  # Controller to show user profile menu page
  class MenusController < ActionController::Base
    before_action :authenticate_user!
    layout 'application'
  end
end
