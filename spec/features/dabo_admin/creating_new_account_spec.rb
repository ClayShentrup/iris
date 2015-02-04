require 'feature_spec_helper'

RSpec.feature 'creating an account' do
  login(:user)

  let!(:hospital_without_system) { create(:hospital) }
  let!(:hospital_with_system) { create(:hospital, :with_hospital_system) }

  let(:hospital_system_name) { hospital_with_system.hospital_system_name }

  def expect_virtual_system_dropdown_to_have_options
    expect(page).to have_select(
      'account_virtual_system_gid',
      options: ['', hospital_system_name, hospital_without_system.name],
      selected: '',
      )
  end

  def expect_default_hospital_dropdown_to_have_no_options
    expect(page).to have_select(
      'account_default_hospital_id',
      options: [],
      )
  end

  background do
    visit new_dabo_admin_account_path
  end

  scenario 'when hospital system is selected' do
    expect_virtual_system_dropdown_to_have_options
    expect_default_hospital_dropdown_to_have_no_options

    click_on 'Create Account'

    expect(page).to have_content 'Virtual system can\'t be blank'
    expect(page).to have_content 'Default hospital can\'t be blank'

    select(hospital_system_name, from: 'account_virtual_system_gid')

    select(hospital_with_system.name, from: 'account_default_hospital_id')
    click_on 'Create Account'

    expect(page).to have_content "Name: #{hospital_system_name}"
    expect(page)
      .to have_content "Default Hospital: #{hospital_with_system.name}"
  end

  scenario 'when hospital is selected' do
    select(hospital_without_system.name, from: 'account_virtual_system_gid')
    select(hospital_without_system.name, from: 'account_default_hospital_id')
    click_on 'Create Account'

    expect(page).to have_content "Name: #{hospital_without_system.name}"
    expect(page)
      .to have_content "Default Hospital: #{hospital_without_system.name}"
  end
end
