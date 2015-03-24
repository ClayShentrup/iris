require 'feature_spec_helper'

RSpec.feature 'Clicking a link after session expires' do
  let(:user) { create(User, :with_associations) }
  let(:url) { '/metrics/public-data/hospital-acquired-conditions' }

  before { log_in user }

  it 'redirects to link target after signing back in' do
    visit url
    find('#measures_nav_container').click_link('Patient Safety Indicator')
    expect(page).to have_selector('h2', text: 'Patient Safety Indicator')

    logout

    click_link 'Hospital-Acquired Conditions'
    expect(page).to have_text('Login')
    log_in user
    expect(current_path).to eq url
  end
end
