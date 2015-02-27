module UserProfiles
  # Controller to show user profile info page
  class InfosController < ActionController::Base
    before_action :authenticate_user!
    layout 'application'
  end
end
