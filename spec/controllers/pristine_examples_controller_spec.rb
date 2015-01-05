require 'rails_helper'

RSpec.describe PristineExamplesController do
  let(:invalid_attributes) { attributes_for(PristineExample, name: '') }
  it_behaves_like 'an ApplicationController'

  it_behaves_like 'an ApplicationController index'
  it_behaves_like 'an ApplicationController create'
  it_behaves_like 'an ApplicationController new'
  it_behaves_like 'an ApplicationController delete'
  it_behaves_like 'an ApplicationController show'
  it_behaves_like 'an ApplicationController edit'
  it_behaves_like 'an ApplicationController update'

  context 'performance' do
    before do
      create_list :pristine_example, 10
    end

    it 'takes less than 15ms', :performance do
      expect { get :index }.to take_less_than 15
    end
  end
end
