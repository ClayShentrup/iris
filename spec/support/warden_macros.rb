# Macros for logging in users
module WardenMacros
  def self.extended(base)
    base.include Warden::Test::Helpers
  end

  def login_user
    let(:current_user) { create(:user) }
    let!(:set_logged_in_state) { login_as(current_user, scope: :user) }
  end

  def login_admin
    let(:current_user) { create(:dabo_admin) }
    let!(:set_logged_in_state) { login_as(current_user, scope: :user) }
  end
end
