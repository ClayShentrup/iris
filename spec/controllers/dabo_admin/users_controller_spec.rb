require 'rails_helper'

RSpec.describe DaboAdmin::UsersController do
  login_admin

  let(:invalid_attributes) { { is_dabo_admin: nil, password: 'new_password' } }

  include_context 'an ApplicationController'
  it_behaves_like 'an ApplicationController index'
  it_behaves_like 'an ApplicationController new'
  it_behaves_like 'an ApplicationController create'
  it_behaves_like 'an ApplicationController edit'
  it_behaves_like 'an ApplicationController show'
  it_behaves_like 'an ApplicationController delete'

  describe 'PUT #update' do
    let(:user) { create(:user) }
    let(:account) { create(:account) }

    context 'with valid params' do
      let(:new_attributes) do
        {
          is_dabo_admin: true,
          password: password,
          account_id: account.id,
        }
      end

      before do
        put :update, id: user, user: new_attributes
      end
    end

    context 'with invalid params' do
      before do
        put :update, id: user, user: invalid_attributes
      end

      it 'assigns the model' do
        expect(assigns(:user)).to eq user
      end

      it 're-renders the "edit" template' do
        expect(response).to render_template :edit
      end
    end
  end
end
