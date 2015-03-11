RSpec.shared_context 'authenticated routing' do
  include_context 'routing'
  let(:warden) do
    instance_double('Warden::Proxy').tap do |warden|
      allow(warden).to receive(:authenticate!).with(scope: :user)
        .and_return(authenticated?)
    end
  end
  let(:user) { instance_double(User) }

  def simulate_running_with_devise
    stub_const(
      'Rack::MockRequest::DEFAULT_ENV',
      Rack::MockRequest::DEFAULT_ENV.merge('warden' => warden),
    )
  end

  before { simulate_running_with_devise }

  let(:authenticated?) { false }
  shared_context 'authenticated' do
    let(:authenticated?) { true }
  end

  shared_examples 'a route' do
    it_behaves_like 'an unroutable route'
    it_behaves_like 'a routable route' do
      include_context 'authenticated'
    end
  end
end
