RSpec.shared_context 'routing' do
  let(:model_name) do
    described_class.name.demodulize.gsub(/Controller$/, '').underscore
  end

  before do
    allow(Constraints::DaboAdmin).to receive(:matches?).once
      .and_return(authorized?)
  end
end

RSpec.shared_context 'user authorized' do
  let(:authorized?) { true }
end

RSpec.shared_context 'user not authorized' do
  let(:authorized?) { false }
end

RSpec.shared_examples 'a DaboAdmin index route' do
  include_context('routing')

  describe 'with an authorized user' do
    include_context('user authorized')

    it 'routes to #index' do
      expect(get: "/dabo_admin/#{model_name}")
        .to route_to("dabo_admin/#{model_name}#index")
    end
  end

  describe 'with an unauthorized user' do
    include_context('user not authorized')

    it 'does not route to #index' do
      expect(get: "/dabo_admin/#{model_name}").not_to be_routable
    end
  end
end

RSpec.shared_examples 'a DaboAdmin new route' do
  include_context('routing')

  describe 'with an authorized user' do
    include_context('user authorized')

    it 'routes to #new' do
      expect(get: "/dabo_admin/#{model_name}/new")
        .to route_to("dabo_admin/#{model_name}#new")
    end
  end

  describe 'with an unauthorized user' do
    include_context('user not authorized')

    it 'does not route to #new' do
      # Due to a bug in Rails/ActionDispatch, custom route constraints
      # are called multiple times for any 'new' action. This will fail
      # once the problem is fixed in Rails. Then this additional allow can
      # be removed
      allow(Constraints::DaboAdmin).to receive(:matches?).twice
        .and_return(authorized?)
      expect(get: "/dabo_admin/#{model_name}/new").not_to be_routable
    end
  end
end

RSpec.shared_examples 'a DaboAdmin show route' do
  include_context('routing')

  describe 'with an authorized user' do
    include_context('user authorized')

    it 'routes to #show' do
      expect(get: "/dabo_admin/#{model_name}/1")
        .to route_to("dabo_admin/#{model_name}#show", id: '1')
    end
  end

  describe 'with an unauthorized user' do
    include_context('user not authorized')

    it 'does not route to #show' do
      expect(get: "/dabo_admin/#{model_name}/1").not_to be_routable
    end
  end
end

RSpec.shared_examples 'a DaboAdmin edit route' do
  include_context('routing')

  describe 'with an authorized user' do
    include_context('user authorized')

    it 'routes to #edit' do
      expect(get: "/dabo_admin/#{model_name}/1/edit")
        .to route_to("dabo_admin/#{model_name}#edit", id: '1')
    end
  end

  describe 'with an unauthorized user' do
    include_context('user not authorized')

    it 'does not route to #edit' do
      expect(get: "/dabo_admin/#{model_name}/1/edit").not_to be_routable
    end
  end
end

RSpec.shared_examples 'a DaboAdmin create route' do
  include_context('routing')

  describe 'with an authorized user' do
    include_context('user authorized')

    it 'routes to #create' do
      expect(post: "/dabo_admin/#{model_name}")
        .to route_to("dabo_admin/#{model_name}#create")
    end
  end

  describe 'with an unauthorized user' do
    include_context('user not authorized')

    it 'does not route to #create' do
      expect(post: "/dabo_admin/#{model_name}").not_to be_routable
    end
  end
end

RSpec.shared_examples 'a DaboAdmin update route' do
  include_context('routing')

  describe 'with an authorized user' do
    include_context('user authorized')

    it 'routes to #update' do
      expect(put: "/dabo_admin/#{model_name}/1")
        .to route_to("dabo_admin/#{model_name}#update", id: '1')
    end
  end

  describe 'with an unauthorized user' do
    include_context('user not authorized')

    it 'does not route to #update' do
      expect(put: '/dabo_admin/users/1').not_to be_routable
    end
  end
end

RSpec.shared_examples 'a DaboAdmin destroy route' do
  include_context('routing')

  describe 'with an authorized user' do
    include_context('user authorized')

    it 'routes to #destroy' do
      expect(delete: "/dabo_admin/#{model_name}/1")
        .to route_to("dabo_admin/#{model_name}#destroy", id: '1')
    end
  end

  describe 'with an unauthorized user' do
    include_context('user not authorized')

    it 'does not route to #destroy' do
      expect(delete: '/dabo_admin/users/1').not_to be_routable
    end
  end
end
