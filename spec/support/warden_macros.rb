# Macros for logging in users in feature specs
module WardenMacros
  def self.extended(base)
    base.include Warden::Test::Helpers
    Warden.test_mode!
  end

  def login_user
    let(:current_user) { create(:user, :with_associations) }
    let!(:set_logged_in_state) { login_as(current_user, scope: :user) }
  end

  def login_admin
    let(:current_user) { create(User, :dabo_admin) }
    let!(:set_logged_in_state) { login_as(current_user, scope: :user) }
  end
end
