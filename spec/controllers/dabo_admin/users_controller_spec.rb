require 'rails_helper'

RSpec.describe DaboAdmin::UsersController do
  login(:dabo_admin)

  let(:invalid_attributes) { { is_dabo_admin: nil, password: 'new_password' } }

  it_behaves_like 'an ApplicationController'
  it_behaves_like 'an ApplicationController index'
  it_behaves_like 'an ApplicationController new'
  it_behaves_like 'an ApplicationController create'
  it_behaves_like 'an ApplicationController edit'
  it_behaves_like 'an ApplicationController show'
  it_behaves_like 'an ApplicationController delete'

  it_behaves_like 'a Dabo Admin page'

  describe 'PUT #update' do
    let(:user) { create(:user) }

    context 'with valid params' do
      let(:new_attributes) { { is_dabo_admin: true, password: password } }

      before do
        put :update, id: user, user: new_attributes
      end

      context 'and blank password' do
        let!(:old_encrypted_password) { user.encrypted_password }
        let(:password) { '' }

        it 'updates the requested model' do
          new_attributes.delete(:password)
          expect(user.reload.attributes)
            .to include new_attributes.stringify_keys
        end

        it 'does not alter the old password' do
          expect(user.reload.encrypted_password)
            .to eq old_encrypted_password
        end

        it 'assigns the requested model' do
          expect(assigns(:user)).to eq user
        end

        it 'redirects to the model show' do
          expect(response).to redirect_to dabo_admin_user_path(user)
        end
      end

      context 'and non-blank password' do
        let(:password) { 'new_password' }

        it 'updates the requested model' do
          expect(user.reload.valid_password?(password)).to be true
        end

        it 'assigns the requested model' do
          expect(assigns(:user)).to eq user
        end

        it 'redirects to the model show' do
          expect(response).to redirect_to dabo_admin_user_path(user)
        end
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
