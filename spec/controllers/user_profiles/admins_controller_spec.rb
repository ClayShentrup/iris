require 'rails_helper'

RSpec.describe UserProfiles::AdminsController do
  login_admin

  it_behaves_like 'a Dabo Admin page'

  describe 'GET #show' do
    subject { get :show }

    it { expect(subject).to render_template('show') }
  end
end
