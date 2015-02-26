require 'rails_helper'

RSpec.describe UserProfilesController do
  login_user

  it_behaves_like 'an ApplicationController'

  describe 'GET show#menu' do
    before { get :show, id: 'menu' }

    specify { expect(response).to be_success }
    specify { expect(response).to render_template partial: '_menu' }
  end

  describe 'show/hide admin menu' do
    context 'logged in as admin' do
      login_admin
      before { get :show, id: 'menu' }

      it 'shows admin menu icon' do
        expect(response.body).to have_link('', href: '/user_profiles/admin')
      end
    end

    context 'not logged in as admin' do
      login_user
      before { get :show, id: 'menu' }

      it 'does not show admin menu icon' do
        expect(response.body).to_not have_link('', href: '/user_profiles/admin')
      end
    end
  end
end
