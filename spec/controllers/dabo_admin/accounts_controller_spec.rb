require 'rails_helper'

RSpec.describe DaboAdmin::AccountsController do
  login_admin

  include_context 'an ApplicationController'
  it_behaves_like 'an ApplicationController index' do
    let(:model_instances) { create_list(Account, 1, :with_associations) }
  end
  it_behaves_like 'an ApplicationController new'
  it_behaves_like 'an ApplicationController delete' do
    let!(:model_instance) { account_instance }
  end
  it_behaves_like 'an ApplicationController show' do
    let!(:model_instance) { account_instance }
  end
  it_behaves_like 'an ApplicationController edit' do
    let!(:model_instance) { account_instance }
  end

  let(:account_instance) { create(Account, :with_associations) }
  let(:instance_url) { dabo_admin_account_path(Account.last) }
  let(:virtual_system) { create(HospitalSystem, :with_associations) }
  let(:default_provider) { virtual_system.providers.last }
  let(:users) { create_list(User, 2) }

  describe 'create' do
    let(:valid_account_params) do
      {
        virtual_system_gid: virtual_system.to_global_id,
        default_provider_id: default_provider.id,
        user_ids: [users.first.id, users.second.id],
      }
    end

    def post_create(account)
      post :create, account: account
    end

    describe 'with valid params' do
      it 'creates a new instance' do
        expect { post_create(valid_account_params) }
          .to change(Account, :count).by(1)
      end

      it 'redirects to the created record' do
        post_create(valid_account_params)
        expect(response).to redirect_to instance_url
      end
    end

    describe 'with invalid params' do
      let(:invalid_account_params) do
        {
          virtual_system_gid: '',
          default_provider_id: '',
          user_ids: [],
        }
      end

      before do
        post_create(invalid_account_params)
      end

      it 'assigns a newly created but unsaved model instance' do
        expect(assigns(:account)).to be_a_new Account
      end

      it 're-renders the "new" template' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'update' do
    let(:new_user) { create(User) }
    let(:new_attributes) do
      {
        virtual_system_gid: virtual_system.to_global_id,
        default_provider_id: default_provider.id,
        user_ids: [new_user.id],
      }
    end

    describe 'with valid params' do
      before do
        put :update, id: account_instance.id,
                     account: new_attributes
      end

      it 'updates the requested model' do
        expect(account_instance.reload.attributes.fetch('default_provider_id'))
          .to eq default_provider.id
      end

      it 'assigns the requested model' do
        expect(assigns(:account)).to eq account_instance
      end

      it 'redirects to the model show' do
        expect(response).to redirect_to instance_url
        expect(flash[:notice]).to be_present
      end
    end
  end
end
