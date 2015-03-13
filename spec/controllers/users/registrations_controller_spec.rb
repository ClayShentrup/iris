require 'rails_helper'

RSpec.describe Users::RegistrationsController do
  let(:user) { build_stubbed :user_for_controller_specs }
  simulate_routed_request

  describe 'POST #update' do
    let(:user) do
      create :user_for_controller_specs,
             password: original_password
    end
    let(:original_password) { 'catadjectivesquarefur' }
    let(:new_password) { 'statementslavedutyleg' }

    simulate_routed_request
    let!(:set_logged_in_state) { sign_in user }

    context 'with valid params' do
      let(:new_attributes) do
        {
          current_password: original_password,
          password: new_password,
          password_confirmation: new_password,
        }
      end

      before do
        put :update, id: user, user: new_attributes
      end

      it 'redirects' do
        expect(response).to redirect_to(user_profiles_settings_path)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        {
          current_password: original_password,
          password: original_password,
          password_confirmation: new_password,
        }
      end

      before do
        put :update, id: user, user: invalid_attributes
      end

      it 'does not redirect' do
        expect(response).to_not redirect_to(user_profiles_settings_path)
      end
    end
  end
end
