RSpec.shared_context 'an ApplicationController' do |trait|
  shared_context 'ApplicationController methods' do
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
      let!(:model_instance) { create(model_class, trait) }
    end
  end

  shared_examples 'an ApplicationController index' do
    include_context 'ApplicationController methods'

    let!(:model_instances) { create_list(model_class, 2) }
    before do
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

  shared_examples 'an ApplicationController create' do
    def post_create(attributes)
      post :create, model_param_name => attributes
    end

    let(:valid_attributes) { attributes_for(model_class) }

    include_context 'ApplicationController base create'

    context 'with valid params' do
      before do
        allow(model_class).to receive(:new).and_return(build(model_class))
      end

      it 'redirects to the created record' do
        post_create(valid_attributes)
        expect(response).to redirect_to instance_url
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid params' do
      it 'populates body css class correctly' do
        post_create(invalid_attributes)
        assert_has_javascript_view_name(:new)
      end
    end
  end

  shared_examples 'an ajax create' do
    def post_create(attributes)
      xhr :post, :create, model_param_name => attributes
    end

    include_context 'ApplicationController base create'

    context 'with ajax valid params' do
      it 'redirects to the index page' do
        post_create(valid_attributes)
        expect(response).to redirect_to index_url
        expect(flash[:notice]).to be_present
      end
    end

    context 'with ajax invalid params' do
      it 'sets the status to "unprocessable_entity(422)"' do
        post_create(invalid_attributes)
        expect(response.status).to eq(422)
      end
    end
  end

  shared_context 'ApplicationController base create' do
    include_context 'ApplicationController methods'

    let(:instance_url) do
      public_send("#{model_params_name_namespace}_path", model_class.last)
    end

    let(:model_name) do
      described_class.name.demodulize.gsub(/Controller$/, '').singularize
    end

    describe 'with valid params' do
      before do
        allow(model_class).to receive(:new).and_return(build(model_class))
      end

      it 'creates a new model instance' do
        expect { post_create(valid_attributes) }
          .to change(model_class, :count).by(1)
      end

      it 'assigns a newly created model instance' do
        post_create(valid_attributes)
        expect(assign).to be_a model_class
        expect(assign).to be_persisted
      end
    end

    describe 'with invalid params' do
      before do
        post_create(invalid_attributes)
      end

      it 'assigns a newly created but unsaved model instance' do
        expect(assign).to be_a_new model_class
      end

      it 're-renders the "new" template' do
        expect(response).to render_template :new
      end
    end
  end

  shared_examples 'an ApplicationController new' do
    include_context 'ApplicationController methods'

    before { get :new }

    specify { expect(response).to be_success }

    it 'assigns a newly created model instance' do
      expect(assign).to be_a_new model_class
    end
  end

  shared_examples 'an ApplicationController delete' do
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
      expect(flash[:notice]).to be_present
    end
  end

  shared_examples 'an ApplicationController show' do
    include_context 'ApplicationController methods'
    include_context 'ApplicationController methods with an existing record'

    before do
      get :show, id: model_instance
    end

    specify { expect(response).to be_success }

    it 'assigns a new model' do
      expect(assign).to eq model_instance
    end
  end

  shared_examples 'an ApplicationController show without a model' do
    include_context 'ApplicationController methods'

    before { get :show }

    specify { expect(response).to be_success }
    specify { expect(response).to render_template :show }
  end

  shared_examples 'an ApplicationController index without a model' do
    include_context 'ApplicationController methods'

    before { get :index }

    specify { expect(response).to be_success }
    specify { expect(response).to render_template :index }
  end

  shared_examples 'an ApplicationController edit' do
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

  shared_examples 'an ApplicationController update' do
    include_context 'ApplicationController methods'
    include_context 'ApplicationController methods with an existing record'
    let(:new_attributes) { attributes_for(model_class) }
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
        expect(flash[:notice]).to be_present
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
end
