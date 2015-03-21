require 'rails_helper'

RSpec.describe Users::RegistrationsController do
  simulate_routed_request

  describe 'POST #create' do
    let!(:authorized_domain) do
      create(AuthorizedDomain, :with_associations, name: domain_name)
    end
    let(:domain_name) { 'mayo.edu' }
    let(:user_attributes) do
      attributes_for(
        User,
        first_name: 'Firstname',
        last_name: 'Lastname',
        email: user_email,
      )
    end

    before { post :create, user: user_attributes }

    context 'user email domain matches existing account' do
      let(:user_email) { "johndoe@#{domain_name}" }

      it 'redirects to a thank you page' do
        expect(response).to redirect_to '/users/sign_up_confirmation'
        expect(response).to_not render_template :new
      end

      it 'creates a new user' do
        expect(User.last!.email).to eq user_email
      end

      it 'sends user a welcome email with instructions to login' do
        expect(response)
      end
    end

    context 'user email domain does not match existing account' do
      let(:user_email) { 'john@unknown_domain.com' }

      it 'instructs the user that his email domain must match an account' do
        expect(assigns(:user).errors).to_not be nil
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT #update' do
    let(:user) do
      create(
        User,
        :authenticatable,
        :with_associations,
        password: original_password,
      )
    end
    let(:original_password) { 'catadjectivesquarefur' }
    let(:new_password) { 'statementslavedutyleg' }
    let!(:set_logged_in_state) { sign_in user }

    context 'with valid params' do
      let(:new_attributes) do
        {
          current_password: original_password,
          password: new_password,
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
