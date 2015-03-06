# This helper file provides shared methods for Dabo Admin Account feature specs
module DropdownSpecHelper
  def expect_default_provider_dropdown_to_have_no_options
    expect(page).to have_select(
      'account_default_provider_id',
      options: [],
    )
  end
end
