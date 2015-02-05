require 'feature_spec_helper'

RSpec.feature 'Select and compare' do
  login(:user)

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

  def click_on_hospital_select
    find('#select_and_compare .dropdown_button.hospital').click
  end

  def click_on_compare_select
    find('#select_and_compare .dropdown_button.compare').click
  end

  background do
    visit url
  end

  scenario 'open hospital widget' do
    expect(page).to have_content('Saint Marys Hospital')
    expect(page).to_not have_content('Hospital Related to User A')

    click_on_hospital_select

    expect(page).to have_content('Hospital Related to User A')

    click_on_hospital_select

    expect(page).to have_content('Saint Marys Hospital')
    expect(page).to_not have_content('Hospital Related to User A')
  end

  scenario 'open compare widget' do
    expect(page).to have_content('Rochester, MN')
    expect(page).to_not have_content('City, State of Selected Hospital')

    click_on_compare_select

    expect(page).to have_content('Rochester, MN')
    expect(page).to have_content('City, State of Selected Hospital')

    click_on_compare_select

    expect(page).to have_content('Rochester, MN')
    expect(page).to_not have_content('City, State of Selected Hospital')
  end

  scenario 'open hospital widget while compare is open' do
    click_on_compare_select

    expect(page).to have_content('Rochester, MN')
    expect(page).to have_content('City, State of Selected Hospital')

    click_on_hospital_select

    expect(page).to have_content('Hospital Related to User A')
    expect(page).to_not have_content('City, State of Selected Hospital')
  end
end
