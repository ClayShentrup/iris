require 'feature_spec_helper'
require 'account_spec_helper'

RSpec.feature 'creating an account' do
  include AccountSpecHelper
  login_admin

  let!(:user) { create(:user) }

  let!(:hospital_without_system) { create(:hospital) }
  let!(:hospital_with_system) { create(:hospital, :with_hospital_system) }

  let(:hospital_system_name) { hospital_with_system.hospital_system_name }

  def expect_virtual_system_dropdown_to_have_options
    expect_dropdown_to_have_options(
      page,
      'account_virtual_system_gid',
      ['', hospital_system_name, hospital_without_system.name],
      '',
    )
  end

  def expect_default_hospital_dropdown_to_have_no_options
    expect_default_dropdown_to_have_no_options(
      page,
      'account_default_hospital_id',
      [],
    )
  end

  background do
    enable_feature(:create_account)
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

    expect(page).to have_content "#{hospital_system_name}"
    expect(page)
      .to have_content "#{hospital_with_system.name}"
    expect(page).to_not have_content user.email
  end

  scenario 'when hospital is selected' do
    select(hospital_without_system.name, from: 'account_virtual_system_gid')
    select(hospital_without_system.name, from: 'account_default_hospital_id')
    click_on 'Create Account'

    expect(page).to have_content "#{hospital_without_system.name}"
    expect(page)
      .to have_content "#{hospital_without_system.name}"
  end

  scenario 'when user is selected' do
    check user.email

    select(hospital_without_system.name, from: 'account_virtual_system_gid')
    select(hospital_without_system.name, from: 'account_default_hospital_id')
    click_on 'Create Account'

    expect(page).to have_content user.email
  end
end
