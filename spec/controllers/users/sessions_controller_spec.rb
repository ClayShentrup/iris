require 'rails_helper'

RSpec.describe Users::SessionsController do
  let(:user) { build_stubbed :user_with_devise_session }
  simulate_routed_request

  save_fixture do
    get :new
  end

  describe 'POST #create' do
    let(:user) { create :user }
    let(:valid_params) do
      {
        email: user.email,
        password: user.password,
      }
    end

    context 'with password about to expire' do
      let(:flash_message) do
        'Human, you have 3 days before your ' \
        'password expires. Please update to a new one.'
      end

      before do
        user.update_attribute(:password_changed_at, Time.current - 86.days)
        post :create, user: valid_params
      end

      it 'shows a flash message reminder' do
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to have_content flash_message
      end
    end

    context 'password not about to expire' do
      before do
        user.update_attribute(:password_changed_at, Time.current)
        post :create, user: valid_params
      end

      it 'does not show a flash message reminder' do
        expect(flash[:notice]).to_not be_present
      end
    end
  end

  describe 'GET #new' do
    let(:user) { create :user_with_devise_session }

    before do
      post :create, user: params
    end

    context 'with a valid user' do
      let(:params) do
        {
          email: user.email,
          password: user.password,
        }
      end

      before do
        post :create, user: params
      end

      it 'logs the user in' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with an invalid user email' do
      let(:params) do
        {
          email: 'foo@bar.com',
          password: 'somepassword',
        }
      end

      it 'redirects to sign in page' do
        expect(response).to render_template :new
      end
    end

    context 'with an invalid password' do
      let(:user) { create :user_with_devise_session }
      let(:params) do
        {
          email: user.email,
          password: 'wrongpasswordyo!',
        }
      end

      it 'redirects to sign in page' do
        expect(response).to render_template :new
      end
    end

    context 'with two failed login attempts' do
      let(:user) { create :user_with_devise_session, failed_attempts: 1 }
      let(:email) { open_email(user.email) }
      let(:params) do
        {
          email: user.email,
          password: 'wrongpasswordyo!',
        }
      end

      it 'should show a locked form and send an email' do
        expect(response).to render_template(
          partial: 'devise/sessions/_reset_password_message',
        )
        expect(email).to deliver_to(user.email)
        expect(email).to have_subject('Reset Dabo Password - Action Required')
      end
    end
  end
end
