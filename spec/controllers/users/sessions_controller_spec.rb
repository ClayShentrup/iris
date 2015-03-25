require 'rails_helper'

RSpec.describe Users::SessionsController do
  simulate_routed_request

  save_fixture do
    get :new
  end

  describe 'POST #create' do
    let(:user) { create(User) }
    let(:valid_params) do
      {
        email: user.email,
        password: user.password,
      }
    end

    context 'with password about to expire' do
      let(:flash_message) do
        "#{user.first_name}, you have 3 days before your " \
        'password expires. Please update to a new one.'
      end

      before do
        user.update_attribute(:password_changed_at, Time.current - 86.days)
        post :create, user: valid_params
      end

      it 'shows a flash message reminder' do
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

    context 'when a user attempts to log in' do
      before do
        post :create, user: { email: user.email }
      end

      it 'stores user email in session cookie' do
        expect(session[:session_email]).to be user.email
      end
    end
  end

  describe 'GET #new' do
    let(:user) { create(User, :authenticatable) }

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
      let(:user) { create(User, :authenticatable) }
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
      let(:user) { create(User, :authenticatable, failed_attempts: 1) }
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
      end
    end
  end
end
