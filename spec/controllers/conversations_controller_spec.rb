require 'rails_helper'

RSpec.describe ConversationsController do
  login_user

  include_context 'an ApplicationController'
  it_behaves_like 'an ApplicationController new'
  it_behaves_like 'an ApplicationController show'

  describe 'GET #show' do
    describe 'generate a fixture' do
      let(:conversation) { create(Conversation) }

      save_fixture do
        get :show, id: conversation.id
      end
    end
  end

  describe 'POST #Create' do
    it_behaves_like 'an ApplicationController create with valid params'

    describe 'with invalid params' do
      let(:invalid_attributes) do
        attributes_for(
          Conversation,
          title: '',
          description: '',
          node_id_component: '',
        )
      end

      before do
        post :create, conversation: invalid_attributes
      end

      it 'assigns a newly created but unsaved model instance' do
        expect(assigns[:conversation]).to be_a_new Conversation
      end

      it 're-renders the "new" template' do
        expect(response).to render_template :new
      end

      it 'sets the status to "unprocessable_entity(422)"' do
        expect(response.status).to eq(422)
      end

      describe 'generate a fixture' do
        save_fixture
      end
    end
  end
end
