require 'rails_helper'

RSpec.describe Users::PasswordExpiredController do
  let!(:user) do
    Timecop.travel(Time.now - 100.days) do
      create(
        User,
        :authenticatable,
        :with_associations,
      )
    end
  end
  let!(:password_last_changed_at) { user.reload.password_changed_at }
  let!(:set_logged_in_state) { sign_in user }
  simulate_routed_request

  save_fixture do
    get :show, id: user
  end

  describe 'PUT #update' do
    let(:redirect_url) { '/user_profiles/info' }

    before do
      allow(controller).to receive(:stored_location_for)
        .with(:user).and_return(redirect_url)
      put :update, id: user, user: params
    end

    context 'password is valid' do
      let(:new_password) { 'passwordpassword' }
      let(:params) do
        {
          password: new_password,
        }
      end

      it 'updates the password' do
        expect(user.reload.password_changed_at)
          .to_not eq password_last_changed_at
      end

      it 'redirects to the page the user was trying to visit' do
        expect(response).to redirect_to redirect_url
      end
    end

    context 'password is invalid' do
      let(:params) do
        {
          password: '2short',
        }
      end

      it 'does not update the password' do
        expect(user.reload.password_changed_at).to eq password_last_changed_at
      end

      it 're-renders the show template' do
        expect(response).to render_template(:show)
      end
    end
  end
end
