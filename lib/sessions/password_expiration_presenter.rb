# Creates a message to remind users their password will expire soon
module Sessions
  PasswordExpirationPresenter = Struct.new(:current_user, :view_context) do
    PASSWORD_WARNING_WINDOW = 5

    def self.call(*args)
      new(*args).call
    end

    def call
      message if password_expires_soon?
    end

    private

    def message
      "#{current_user.first_name}, you have #{days_left} #{day_pluralized} " \
      "before your password expires. Please #{update_password_link}."
    end

    def time_left
      Devise.expire_password_after.to_i - time_since_password_changed
    end

    def days_left
      (time_left / seconds_per_day).to_i
    end

    def day_pluralized
      'day'.pluralize(days_left)
    end

    def seconds_per_day
      60 * 60 * 24
    end

    def time_since_password_changed
      Time.current - current_user.password_changed_at
    end

    def password_expires_soon?
      days_left < PASSWORD_WARNING_WINDOW
    end

    def update_password_link
      view_context.link_to('update to a new one', update_password_path)
    end

    def update_password_path
      Rails.application.routes.url_helpers.edit_user_registration_path
    end
  end
end
