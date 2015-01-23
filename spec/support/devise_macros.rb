# Macros for testing devise authentication in controllers
module DeviseMacros
  def login_admin
    let(:current_user) { FactoryGirl.create :admin, password: 'password' }
    let!(:devise_mapping) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end
    let!(:set_logged_in_state) { sign_in current_user }
  end

  def login_user
    let(:current_user) { FactoryGirl.create :user, password: 'password' }
    let!(:devise_mapping) do
      request.env['devise.mapping'] = Devise.mappings[:user]
    end
    let!(:set_logged_in_state) { sign_in current_user }
  end

  def logout_user
    let(:current_user) { nil }
    let!(:devise_mapping) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end
    let!(:set_logged_in_state) {}
  end

  def simulate_routed_request
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end
  end
end
