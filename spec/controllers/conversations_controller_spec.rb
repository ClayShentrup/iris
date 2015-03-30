require 'rails_helper'

RSpec.describe ConversationsController do
  login_user

  include_context 'an ApplicationController'
  it_behaves_like 'an ApplicationController show'

  let(:a_measure_id) { 'some-measure-id' }

  describe 'GET #index' do
    let!(:conversation) do
      create(
        Conversation,
        measure_id: a_measure_id,
        author: current_user,
        provider: current_user.selected_provider,
      )
    end
    let!(:comment) do
      create(
        Comment,
        conversation: conversation,
        author: current_user,
      )
    end

    before do
      xhr :get, :index, measure_id: a_measure_id
    end

    specify { expect(response).to be_successful }

    it 'renders one conversation' do
      expect(response).to render_template(:index)
      expect(response).to render_template('conversations/_conversation')
      expect(response).to render_template('comments/_comment')
    end

    save_fixture
  end

  describe 'GET #show' do
    describe 'generate a fixture' do
      let(:conversation) { create(Conversation) }
      save_fixture do
        xhr :get, :show, id: conversation
      end
    end
  end

  describe 'POST #Create' do
    let(:invalid_attributes) do
      attributes_for(
        Conversation,
        title: '',
        description: '',
        measure_id: '',
      )
    end

    let(:valid_attributes) do
      attributes_for(Conversation, measure_id: a_measure_id)
    end

    let(:index_url) do
      "/conversations?measure_id=#{a_measure_id}"
    end

    it_behaves_like 'an ajax create'

    describe 'generates a fixture with invalid params' do
      save_fixture do
        xhr :post, :create, conversation: invalid_attributes
      end
    end
  end
end
