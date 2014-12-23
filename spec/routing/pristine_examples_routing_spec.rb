require 'rails_helper'

RSpec.describe PristineExamplesController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/pristine_examples').to route_to('pristine_examples#index')
    end

    it 'routes to #new' do
      expect(get: '/pristine_examples/new').to route_to('pristine_examples#new')
    end

    it 'routes to #show' do
      expect(get: '/pristine_examples/1')
        .to route_to('pristine_examples#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/pristine_examples/1/edit')
        .to route_to('pristine_examples#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/pristine_examples').to route_to('pristine_examples#create')
    end

    it 'routes to #update' do
      expect(put: '/pristine_examples/1')
        .to route_to('pristine_examples#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/pristine_examples/1')
        .to route_to('pristine_examples#destroy', id: '1')
    end
  end
end
