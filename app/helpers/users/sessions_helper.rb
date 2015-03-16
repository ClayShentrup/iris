module Users
  # Adds styling to invalid login form fields
  module SessionsHelper
    def failed_login_options
      { class: ('field_with_errors' if failed_login_attempt?) }
    end

    private

    def failed_login_attempt?
      resource_params.present?
    end
  end
end
