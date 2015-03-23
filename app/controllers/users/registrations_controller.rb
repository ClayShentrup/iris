module Users
  # Controller to handle redirect after changing password
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters

    INVALID_DOMAIN_ERROR = 'address is not associated with a ' \
                           'registered account.'

    def create
      super do |user|
        unless user.account
          user.errors[:account].clear
          user.errors.add(:email, INVALID_DOMAIN_ERROR)
        end
      end
    end

    private

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) do |user|
        user.permit(:first_name, :last_name, :email, :password)
      end
    end

    def build_resource(user_params)
      super.tap do |user|
        user.account = Registrations::FindAccountByEmailDomain.call(user.email)
      end
    end

    def after_update_path_for(_resource)
      user_profiles_settings_path
    end

    def after_inactive_sign_up_path_for(_resource)
      users_sign_up_confirmation_path
    end
  end
end
