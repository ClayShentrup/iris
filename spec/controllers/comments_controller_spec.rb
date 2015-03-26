require 'rails_helper'

RSpec.describe CommentsController do
  login_user

  include_context 'an ApplicationController'
  it_behaves_like 'an ApplicationController show'

  describe 'POST #create' do
    it_behaves_like 'an ApplicationController create with valid params'

    describe 'with invalid params' do
      let(:invalid_attributes) do
        attributes_for(Comment, content: '')
      end
      before do
        post :create, comment: invalid_attributes
      end

      it 'assigns a newly created but unsaved model instance' do
        expect(assigns[:comment]).to be_a_new Comment
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
