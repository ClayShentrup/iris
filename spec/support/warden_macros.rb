# Macros for logging in users
module WardenMacros
  def self.extended(base)
    base.include Warden::Test::Helpers
  end

  def login(role)
    let(:current_user) { create(role) }
    let!(:set_logged_in_state) { login_as(current_user, scope: :user) }
  end
end
