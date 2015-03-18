module Users
  # Controller to overwrite the default Devise #update, which requires
  # the current password in order to update
  class PasswordExpiredController < Devise::PasswordExpiredController
    def update
      if resource.update_attributes(resource_params)
        login_user
      else
        clean_up_passwords(resource)
        respond_with(resource, action: :show)
      end
    end

    private

    def login_user
      warden.session(scope)['password_expired'] = false
      set_flash_message :notice, :updated
      sign_in scope, resource, bypass: true
      redirect_to stored_location_for(scope) || :root
    end
  end
end
