require 'feature_spec_helper'

RSpec.feature 'Select and compare' do
  login_user

  given(:url) do
    %w[
      /
      metrics
      public-data
      value-based-purchasing
      patient-experience-of-care
      communication
    ].join('/')
  end

  def click_on_compare_select
    find('#select_and_compare .dropdown_button.compare').click
  end

  background do
    visit url
  end

  scenario 'open compare widget' do
    expect(page).to have_content('Rochester, MN')
    expect(page).to_not have_content('Search a hospital')

    click_on_compare_select

    expect(page).to have_content('Rochester, MN')
    expect(page).to have_content('City, State of Selected Hospital')

    click_on_compare_select

    expect(page).to have_content('Rochester, MN')
    expect(page).to_not have_content('Search a hospital')
  end
end
