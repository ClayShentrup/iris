RSpec.shared_context 'Dabo admin routing' do
  include_context 'authenticated routing'

  before do
    allow(warden).to receive(:user).with(:user).and_return(user)
    allow(Constraints::IsDaboAdmin).to receive(:call).with(user)
      .and_return(is_dabo_admin?)
  end

  shared_context 'is Dabo admin' do
    let(:is_dabo_admin?) { true }
  end

  shared_examples 'a route' do
    let(:is_dabo_admin?) { false }
    include_context 'authenticated'
    it_behaves_like 'an unroutable route'
    it_behaves_like 'a routable route' do
      include_context 'is Dabo admin'
    end
  end
end
