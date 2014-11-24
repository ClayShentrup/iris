shared_examples 'a controller which ensures a JSON request' do
  controller do
    def custom
      render json: { foo: :bar }
    end
  end

  let(:response_data) { { foo: :bar } }
  let(:params) { {} }
  let(:headers) { {} }

  before do
    routes.draw { get 'custom' => 'api/hospitals#custom' }
    request.headers.merge!(headers)
    get :custom, params
  end

  context 'not a JSON request' do
    it 'renders nothing' do
      expect(response.body).to eq ' '
    end

    it 'sets the status code to unacceptable' do
      expect(response.status).to eq 406
    end
  end

  shared_examples 'a JSON request' do
    specify { expect(response).to be_success }

    it 'executes as normal' do
      expect(response.body).to eq response_data.to_json
    end
  end

  context 'the format is JSON' do
    let(:params) { { format: :json } }

    it_behaves_like 'a JSON request'
  end

  context 'the headers accept JSON' do
    let(:headers) { { 'HTTP_ACCEPT' => 'application/json' } }

    it_behaves_like 'a JSON request'
  end
end
