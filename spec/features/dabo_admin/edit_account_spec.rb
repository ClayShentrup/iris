require 'feature_spec_helper'

RSpec.feature 'editing an account' do
  include DropdownSpecHelper
  login_admin

  let!(:user) { create(:user) }
  let!(:account) { create(:account) }
  let(:hospital) { account.default_hospital }
  let(:hospital_system) { account.virtual_system }

  let!(:new_hospital) { create(:hospital) }

  def expect_virtual_system_dropdown_to_have_options
    expect(page).to have_select(
      'account_virtual_system_gid',
      options: [hospital_system.name, new_hospital.name],
      selected: hospital_system.name,
    )
  end

  def expect_default_hospital_dropdown_to_have_options
    expect(page).to have_select(
      'account_default_hospital_id',
      options: [hospital.name],
      selected: hospital.name,
    )
  end

  background do
    visit edit_dabo_admin_account_path(account)
    expect_virtual_system_dropdown_to_have_options
    expect_default_hospital_dropdown_to_have_options
  end

  feature 'when updating the hospital system' do
    scenario 'the account is updated when changing the system' do
      select(new_hospital.name, from: 'account_virtual_system_gid')
      click_on 'Update Account'

      expect(page).to have_content "#{new_hospital.name}"
      expect(page).to have_content "#{new_hospital.name}"
    end
  end

  scenario 'when a user is added to or removed from the account' do
    check user.email
    click_on 'Update Account'
    expect(page).to have_content user.email

    visit edit_dabo_admin_account_path(account)

    uncheck user.email
    click_on 'Update Account'
    expect(page).to_not have_content user.email
  end
end
