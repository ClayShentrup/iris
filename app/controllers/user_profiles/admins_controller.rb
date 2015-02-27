module UserProfiles
  # Controller to show user profile admin page
  class AdminsController < ApplicationController
    before_action EnsureAdminFilter
  end
end
