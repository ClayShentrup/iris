require 'rails_helper'

RSpec.describe UserProfiles::MenusController do
  login_user

  describe 'GET #show' do
    subject { get :show }

    it { expect(subject).to render_template('show') }
  end
end
