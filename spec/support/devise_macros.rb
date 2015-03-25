# Macros for testing devise authentication in controllers
module DeviseMacros
  def self.extended(base)
    base.include Devise::TestHelpers
  end

  def login_user
    let(:current_user) { create(User, :authenticatable, :with_associations) }
    simulate_routed_request
    let!(:set_logged_in_state) { sign_in current_user }
  end

  def login_admin
    let(:current_user) { create(User, :dabo_admin) }
    simulate_routed_request
    let!(:set_logged_in_state) { sign_in current_user }
  end

  def logout
    let!(:set_logged_out_state) { sign_out current_user }
  end

  def simulate_routed_request
    let!(:devise_mapping) do
      @request.env['devise.mapping'] = Devise.mappings.fetch(:user)
    end
  end
end
