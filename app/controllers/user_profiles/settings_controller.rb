module UserProfiles
  # Controller to show user profile setting page
  class SettingsController < ActionController::Base
    before_action :authenticate_user!
    layout 'application'
  end
end
