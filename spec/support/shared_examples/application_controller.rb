RSpec.shared_context 'ApplicationController custom route' do
  controller do
    def custom
    end
  end

  before do
    this_controller = controller
    routes.draw do
      get 'custom' => "#{this_controller.controller_path}#custom"
    end
  end
end

RSpec.shared_examples 'an ApplicationController without authentication' do
  include_context 'ApplicationController custom route'

  describe 'before filters' do
    let(:headers) { {} }
    let(:params) { {} }

    before do
      request.headers.merge!(headers)
      get :custom, params
    end

    describe 'handling a non-HTML request' do
      shared_examples 'a non-HTML request' do
        it 'renders nothing' do
          expect(response.body).to eq ''
        end

        it 'sets the status code to unacceptable' do
          expect(response.status).to eq 406
        end
      end

      context 'extension is non-HTML' do
        let(:params) { { format: :json } }

        it_behaves_like 'a non-HTML request'
      end

      context 'the headers accept something other than HTML' do
        let(:headers) { { 'HTTP_ACCEPT' => 'application/json' } }

        it_behaves_like 'a non-HTML request'
      end
    end
  end

  describe 'rendering views in controller specs' do
    # This ensures that rspec_rails config.render_views is set to true,
    # ensuring that our templates correctly render, which further tests
    # that our Rails controllers are functioning correctly.
    it 'renders the view' do
      expect { get :custom }.to raise_error ActionView::MissingTemplate
    end
  end
end

RSpec.shared_examples 'an ApplicationController' do
  it_behaves_like 'an ApplicationController without authentication'

  describe 'authentication' do
    include_context 'ApplicationController custom route'

    context 'user is not logged' do
      logout

      before do
        get :custom
      end

      it 'is redirected to login page' do
        is_expected.to redirect_to(new_user_session_url)
      end
    end
  end
end

RSpec.shared_context 'ApplicationController methods' do
  let(:model_class) { model_name.constantize }
  let(:namespace) { "#{described_class.name.deconstantize.underscore}" }
  let(:models_param_name_namespace) do
    [namespace, models_param_name].reject(&:blank?).join('_')
  end
  let(:model_params_name_namespace) do
    [namespace, model_param_name].reject(&:blank?).join('_')
  end
  let(:models_param_name) { model_param_name.pluralize }
  let(:model_param_name) { model_name.underscore }
  let(:model_name) do
    described_class.name.demodulize.gsub(/Controller$/, '').singularize
  end
  let(:assign) { assigns(model_param_name) }

  def assert_has_javascript_view_name(action_name)
    assert_select selector_for_action(action_name)
  end

  def selector_for_action(action_name)
    "body[data-view-name='#{models_param_name}-#{action_name}']"
  end

  shared_context 'ApplicationController methods with an existing record' do
    let!(:model_instance) { create(model_class) }
  end
end

RSpec.shared_examples 'an ApplicationController index' do
  include_context 'ApplicationController methods'

  before do
    create_list(model_class, 2)
    get :index
  end

  specify do
    expect(response).to be_success
  end

  it 'assigns a new instance as @model_instance' do
    expect(assigns(models_param_name)).to eq model_class.all
  end

  it 'populates body css class correctly' do
    assert_has_javascript_view_name(:index)
  end
end

RSpec.shared_examples 'an ApplicationController create' do
  include_context 'ApplicationController methods'
  let(:model_attributes) { attributes_for(model_class) }
  let(:instance_url) do
    public_send("#{model_params_name_namespace}_path", model_class.last)
  end

  let(:model_name) do
    described_class.name.demodulize.gsub(/Controller$/, '').singularize
  end

  def create
    post :create, model_param_name => model_attributes
  end

  describe 'with valid params' do
    it 'creates a new model instance' do
      expect { create }.to change(model_class, :count).by(1)
    end

    it 'assigns a newly created model instance' do
      create
      expect(assign).to be_a model_class
      expect(assign).to be_persisted
    end

    it 'redirects to the created record' do
      create
      expect(response).to redirect_to instance_url
    end
  end

  describe 'with invalid params' do
    before do
      post :create, model_param_name => invalid_attributes
    end

    it 'assigns a newly created but unsaved model instance' do
      expect(assign).to be_a_new model_class
    end

    it 're-renders the "new" template' do
      expect(response).to render_template :new
    end

    it 'populates body css class correctly' do
      assert_has_javascript_view_name(:new)
    end
  end
end

RSpec.shared_examples 'an ApplicationController new' do
  include_context 'ApplicationController methods'
  before { get :new }

  specify do
    expect(response).to be_success
  end

  it 'assigns a newly created model instance' do
    expect(assign).to be_a_new model_class
  end
end

RSpec.shared_examples 'an ApplicationController delete' do
  include_context 'ApplicationController methods'
  include_context 'ApplicationController methods with an existing record'

  subject { delete :destroy, id: model_instance }
  let(:index_url) { public_send("#{models_param_name_namespace}_url") }

  def delete_record
    delete :destroy, id: model_instance
  end

  it 'destroys the requested model record' do
    expect { delete_record }.to change(model_class, :count).by(-1)
  end

  it 'redirects to the index view' do
    delete_record
    expect(response).to redirect_to index_url
  end
end

RSpec.shared_examples 'an ApplicationController show' do
  include_context 'ApplicationController methods'
  include_context 'ApplicationController methods with an existing record'
  before { get :show, id: model_instance }

  specify do
    expect(response).to be_success
  end

  it 'assigns a new model' do
    expect(assign).to eq model_instance
  end
end

RSpec.shared_examples 'an ApplicationController edit' do
  include_context 'ApplicationController methods'
  include_context 'ApplicationController methods with an existing record'
  before { get :edit, id: model_instance }

  specify do
    expect(response).to be_success
  end

  it 'assigns the requested model' do
    expect(assign).to eq model_instance
  end
end

RSpec.shared_examples 'an ApplicationController update' do |update_attributes|
  include_context 'ApplicationController methods'
  include_context 'ApplicationController methods with an existing record'
  let(:new_attributes) { update_attributes || attributes_for(model_class) }
  let(:instance_url) do
    public_send("#{model_params_name_namespace}_path", model_instance)
  end

  describe 'with valid params' do
    before do
      put :update, id: model_instance, model_param_name => new_attributes
    end

    it 'updates the requested model' do
      expect(model_instance.reload.attributes)
        .to include new_attributes.stringify_keys
    end

    it 'assigns the requested model' do
      expect(assign).to eq model_instance
    end

    it 'redirects to the model show' do
      expect(response).to redirect_to instance_url
    end
  end

  describe 'with invalid params' do
    render_views
    before do
      put :update, id: model_instance, model_param_name => invalid_attributes
    end

    it 'assigns the model' do
      expect(assign).to eq model_instance
    end

    it 're-renders the "edit" template' do
      expect(response).to render_template :edit
    end
  end
end
