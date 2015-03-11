require 'rails_helper'

RSpec.describe Users::SessionsController do
  let(:user) { build_stubbed :user_with_devise_session }
  simulate_routed_request

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
        'Human, you have 4 days before your ' \
        'password expires. Please update to a new one.'
      end

      before do
        user.update_attribute(:password_changed_at, Time.now - 86.days)
        post :create, user: valid_params
      end

      it 'shows a flash message reminder' do
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to have_content flash_message
      end
    end

    context 'password not about to expire' do
      before do
        user.update_attribute(:password_changed_at, Time.now)
        post :create, user: valid_params
      end

      it 'does not show a flash message reminder' do
        expect(flash[:notice]).to_not be_present
      end
    end
  end
end
