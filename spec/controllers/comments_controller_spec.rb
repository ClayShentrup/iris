require 'rails_helper'

RSpec.describe CommentsController do
  login_user

  include_context 'an ApplicationController'
  it_behaves_like 'an ApplicationController show'

  describe 'POST #create' do
    let(:a_measure_id) { 'a-node-id-component' }
    let(:conversation) do
      create(Conversation, measure_id: a_measure_id)
    end
    let(:assign) { assigns(:comment) }

    def post_create(attributes)
      post :create, comment: attributes
    end

    context 'with valid params' do
      let(:index_url) do
        "/conversations?measure_id=#{a_measure_id}"
      end
      let(:valid_attributes) do
        attributes_for(Comment, conversation_id: conversation.id)
      end

      it 'creates a new model instance' do
        expect { post_create(valid_attributes) }
          .to change(Comment, :count).by(1)
      end

      it 'assigns a newly created model instance' do
        post_create(valid_attributes)
        expect(assign).to be_a Comment
        expect(assign).to be_persisted
      end

      it 'redirects to the Conversations index page' do
        post_create(valid_attributes)
        expect(response).to redirect_to index_url
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        attributes_for(Comment, conversation_id: conversation.id, content: '')
      end

      before do
        post_create(invalid_attributes)
      end

      it 'assigns a newly created but unsaved model instance' do
        expect(assign).to be_a_new Comment
      end

      it 're-renders the "new" template' do
        expect(response).to render_template :new
      end

      it 'sets the status to "unprocessable_entity(422)"' do
        post_create(invalid_attributes)
        expect(response.status).to eq(422)
      end

      describe 'generates a fixture with invalid params' do
        save_fixture do
          xhr :post, :create, comment: invalid_attributes
        end
      end
    end
  end
end
