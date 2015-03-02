require 'rails_helper'

RSpec.describe DaboAdmin::UsersController do
  describe 'routing' do
    before do
      allow(Constraints::DaboAdmin).to receive(:matches?).once
        .and_return(authorized?)
    end

    context 'user authorized' do
      let(:authorized?) { true }

      it 'routes to #index' do
        expect(get: '/dabo_admin/users').to route_to('dabo_admin/users#index')
      end

      it 'routes to #new' do
        expect(get: '/dabo_admin/users/new').to route_to('dabo_admin/users#new')
      end

      it 'routes to #show' do
        expect(get: '/dabo_admin/users/1')
          .to route_to('dabo_admin/users#show', id: '1')
      end

      it 'routes to #edit' do
        expect(get: '/dabo_admin/users/1/edit')
          .to route_to('dabo_admin/users#edit', id: '1')
      end

      it 'routes to #create' do
        expect(post: '/dabo_admin/users').to route_to('dabo_admin/users#create')
      end

      it 'routes to #update' do
        expect(put: '/dabo_admin/users/1')
          .to route_to('dabo_admin/users#update', id: '1')
      end

      it 'routes to #destroy' do
        expect(delete: '/dabo_admin/users/1')
          .to route_to('dabo_admin/users#destroy', id: '1')
      end
    end

    context 'user not authorized' do
      let(:authorized?) { false }

      it 'routes to #index' do
        expect(get: '/dabo_admin/users').not_to be_routable
      end

      it 'routes to #new' do
        # Due to a bug in Rails/ActionDispatch, custom route constraints
        # are called multiple times for any 'new' action. This will fail
        # once the problem is fixed in Rails. Then this additional allow can
        # be removed
        allow(Constraints::DaboAdmin).to receive(:matches?).twice
          .and_return(authorized?)
        expect(get: '/dabo_admin/users/new').not_to be_routable
      end

      it 'routes to #show' do
        expect(get: '/dabo_admin/users/1').not_to be_routable
      end

      it 'routes to #edit' do
        expect(get: '/dabo_admin/users/1/edit').not_to be_routable
      end

      it 'routes to #create' do
        expect(post: '/dabo_admin/users').not_to be_routable
      end

      it 'routes to #update' do
        expect(put: '/dabo_admin/users/1').not_to be_routable
      end

      it 'routes to #destroy' do
        expect(delete: '/dabo_admin/users/1').not_to be_routable
      end
    end
  end
end
