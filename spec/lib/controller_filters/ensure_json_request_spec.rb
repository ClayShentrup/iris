require 'controller_filters/ensure_json_request'
require 'active_support/hash_with_indifferent_access'
require 'action_dispatch/http/headers'

RSpec.describe ControllerFilters::EnsureJsonRequest do
  let(:controller) do
    instance_double('ApplicationController', params: params).tap do |controller|
      allow(controller).to receive_message_chain(:request, :headers)
        .and_return(headers)
    end
  end
  let(:params) { {} }
  let(:headers) do
    ActionDispatch::Http::Headers.new
  end

  def run_filter
    described_class.before(controller)
  end

  context 'not a JSON request' do
    it 'renders nothing and sets an unacceptable status code' do
      expect(controller).to receive(:render).with(
        nothing: true,
        status: :not_acceptable,
      )
      run_filter
    end
  end

  shared_examples 'a JSON request' do
    specify { expect(controller).not_to receive(:render) }
  end

  context 'the format is JSON' do
    let(:params) { { format: 'json' } }

    it_behaves_like 'a JSON request'
  end

  context 'the headers accept JSON' do
    let(:headers) do
      ActionDispatch::Http::Headers.new(
        'HTTP_Accept' => 'application/json',
      )
    end

    it_behaves_like 'a JSON request'
  end
end
