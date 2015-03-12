# Controller to handle redirect after changing password
class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_update_path_for(_resource)
    user_profiles_settings_path
  end
end
