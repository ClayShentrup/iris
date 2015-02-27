require 'rails_helper'

RSpec.describe UserProfiles::InfosController do
  login_user

  describe 'GET #show' do
    subject { get :show }

    it { expect(subject).to render_template('show') }
  end
end
