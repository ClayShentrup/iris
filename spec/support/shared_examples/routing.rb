RSpec.shared_context 'routing' do
  let(:controller_string) do
    described_class.name.underscore.sub(/_controller$/, '')
  end

  let(:expected_route) { "#{controller_string}##{action}" }
  let(:base_path) { "/#{resource_name}" }

  let(:expected_route_options) { [expected_route] }

  shared_context 'a plural resource' do
    let(:resource_path) { "#{base_path}/#{id}" }
    let(:resource_name) { controller_string }
    let(:id) { '42' }

    shared_context 'require id for plural resource' do
      let(:expected_route_options) { [expected_route, id: id] }
    end
  end
  include_context 'a plural resource'

  shared_examples 'a routable route' do
    specify { expect(route_options).to route_to(*expected_route_options) }
  end

  shared_examples 'an unroutable route' do
    specify { expect(route_options).not_to be_routable }
  end

  shared_examples 'a route' do
    it_behaves_like 'a routable route'
  end

  # None of the preceding shared contexts or examples should be used outside
  # of this file.
  shared_context 'a singular resource' do
    let(:resource_path) { base_path }
    let(:resource_name) { controller_string.singularize }
    shared_context 'require id for plural resource' do
    end
  end

  shared_examples 'an index route' do
    let(:action) { :index }
    let(:route_options) { { get: base_path } }
    it_behaves_like 'a route'
  end

  shared_examples 'a new route' do
    let(:action) { :new }
    let(:route_options) { { get: "#{base_path}/new" } }
    it_behaves_like 'a route'
  end

  shared_examples 'a show route' do
    include_context('require id for plural resource')
    let(:action) { :show }
    let(:route_options) { { get: resource_path } }
    it_behaves_like 'a route'
  end

  shared_examples 'an update route' do
    include_context('require id for plural resource')
    let(:action) { :update }
    let(:route_options) { { put: resource_path } }
    it_behaves_like 'a route'
  end

  shared_examples 'a destroy route' do
    include_context('require id for plural resource')
    let(:action) { :destroy }
    let(:route_options) { { delete: resource_path } }
    it_behaves_like 'a route'
  end

  shared_examples 'an edit route' do
    include_context('require id for plural resource')
    let(:action) { :edit }
    let(:route_options) { { get: "#{resource_path}/edit" } }
    it_behaves_like 'a route'
  end

  shared_examples 'a create route' do
    let(:action) { :create }
    let(:route_options) { { post: base_path } }
    it_behaves_like 'a route'
  end
end
