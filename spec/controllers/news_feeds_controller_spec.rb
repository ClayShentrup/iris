require 'rails_helper'

RSpec.describe NewsFeedsController do
  login_user

  it_behaves_like 'an ApplicationController'

  context 'show action' do
    before { get :show }

    specify { expect(response).to be_success }

    specify { expect(response).to render_template :show }
  end

  context 'performance', :performance do
    it 'takes a short time to execute' do
      expect { get :show }.to take_less_than :short_time
    end
  end
end
