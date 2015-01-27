require 'rails_helper'

RSpec.describe DaboAdmin::UsersController do
  describe 'routing' do
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
end
