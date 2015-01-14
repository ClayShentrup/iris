require 'rails_helper'

RSpec.describe SystemsController do
  let(:invalid_attributes) { attributes_for(System, name: '') }
  it_behaves_like 'an ApplicationController'

  it_behaves_like 'an ApplicationController index'
  it_behaves_like 'an ApplicationController create'
  it_behaves_like 'an ApplicationController new'
  it_behaves_like 'an ApplicationController delete'
  it_behaves_like 'an ApplicationController show'
  it_behaves_like 'an ApplicationController edit'
  it_behaves_like 'an ApplicationController update'

  context 'performance', :performance do
    before do
      create_list :system, 10
    end

    it 'takes a short time to execute' do
      expect { get :index }.to take_less_than :short_time
    end
  end
end
