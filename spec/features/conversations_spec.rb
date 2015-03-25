require 'feature_spec_helper'

RSpec.feature 'Conversations' do
  login_user

  given(:node_id) do
    'public-data/hospital-acquired-conditions/' \
      'patient-safety-indicator/patient-safety-composite'
  end

  given(:patient_safety_measure_path) { "/metrics/#{node_id}" }
  given!(:conversation) do
    create(
      Conversation,
      node_id_component: node_id,
      author: current_user,
      provider: current_user.selected_provider,
    )
  end

  background do
    visit(patient_safety_measure_path)
    expect(page).not_to have_css('#form_description')
    fill_in 'Start A Conversation', with: 'test'
  end

  scenario 'clicking on the subject opens the description' do
    expect(page).to have_css('#form_description')
  end

  scenario 'clicking away from the form closes the description' do
    first('.main_content').click
    expect(page).not_to have_css('#form_description')
  end
end
