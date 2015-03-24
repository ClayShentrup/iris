require 'rails_helper'

RSpec.describe DaboAdmin::AuthorizedDomainsController  do
  let!(:model_instance) { create(AuthorizedDomain, :with_associations) }
  let(:invalid_attributes) { attributes_for(AuthorizedDomain, name: '') }
  let(:instance_url) do
    dabo_admin_authorized_domain_path(AuthorizedDomain.last)
  end
  let(:account) { create(Account) }
  login_admin

  include_context 'an ApplicationController', :with_associations
  it_behaves_like 'an ApplicationController show'
  it_behaves_like 'an ApplicationController edit'
  it_behaves_like 'an ApplicationController update'

  describe '#index' do
    context 'account with no authorized domains' do
      let(:account) { create(Account) }
      before do
        get :index, account_id: account.id
      end
      specify { expect(response).to be_success }
      it 'populates body CSS class correctly' do
        assert_select "body[data-view-name='authorized_domains-index']"
      end
      it 'does not have any authorized domains' do
        expect(assigns(:authorized_domains)).to be_empty
      end
    end

    context 'account with authorized domains' do
      let(:account) { create(Account) }
      let!(:authorized_domains) do
        create_list(:authorized_domain, 2, account: account)
      end
      before do
        get :index, account_id: account.id
      end

      it 'assigns a new instance as @authorized_domains' do
        expect(assigns(:authorized_domains)).to eq authorized_domains
      end
    end
  end

  describe '#create' do
    let(:valid_authorized_domain) { { name: 'dabohealth.com' } }
    let(:invalid_authorized_domain) { { name: 'invalid' } }
    def post_create(authorized_domain)
      post :create, authorized_domain: authorized_domain, account_id: account.id
    end

    describe 'with valid params' do
      it 'creates a new instance' do
        expect { post_create(valid_authorized_domain) }
          .to change(AuthorizedDomain, :count).by(1)
      end

      it 'redirects to the created record' do
        post_create(valid_authorized_domain)
        expect(response).to redirect_to instance_url
      end
    end

    describe 'with invalid params' do
      before do
        post_create(invalid_authorized_domain)
      end
      it 'assigns a newly created but unsaved model instance' do
        expect(assigns(:authorized_domain)).to be_a_new AuthorizedDomain
      end

      it 're-renders the "new" template' do
        expect(response).to render_template :new
      end
    end
  end

  describe '#new' do
    before { get :new, account_id: account.id }

    specify { expect(response).to be_success }
  end

  describe '#delete' do
    let!(:authorized_domain) { create(AuthorizedDomain, :with_associations) }
    let(:index_url) do
      dabo_admin_account_authorized_domains_path(authorized_domain.account)
    end

    def delete_record
      delete :destroy, id: authorized_domain
    end

    it 'destroys the AuthorizedDomain record' do
      expect { delete_record }.to change(AuthorizedDomain, :count).by(-1)
    end

    it 'redirects to the AuthorizedDomain index view' do
      delete_record
      expect(response).to redirect_to index_url
      expect(flash[:notice]).to be_present
    end
  end
end
