# User Profile controller
class UserProfilesController < ActionController::Base
  before_action :authenticate_user!
  layout 'application'

  def show
    @partial = params.fetch(:id)
  end
end
