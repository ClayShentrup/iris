# Macros for testing devise authentication in request specs
module ControllerAuthenticationMacros
  def login_admin
    let(:current_user) { FactoryGirl.create :admin }
    let!(:devise_mapping) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end
    let!(:confirmed_state) { current_user.confirm! }
    let!(:set_logged_in_state) { sign_in current_user }
  end

  def login_user
    let(:current_user) { FactoryGirl.create :user }
    let!(:devise_mapping) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end
    let!(:confirmed_state) { current_user.confirm! }
    let!(:set_logged_in_state) { sign_in current_user }
  end

  def logout_user
    let!(:devise_mapping) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end
    let!(:set_logged_out_state) { sign_out current_user }
  end

  def simulate_routed_request
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end
  end
end
