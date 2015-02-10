require 'rails_helper'

# This helper file provides shared methods for Dabo Admin Account feature specs
module DropdownSpecHelper
  def expect_dropdown_to_have_options(page, dropdown_id, options, selected)
    expect(page).to have_select(
      dropdown_id,
      options: options,
      selected: selected,
    )
  end

  def expect_default_dropdown_to_have_no_options(page, dropdown_id, options)
    expect(page).to have_select(
      dropdown_id,
      options: options,
    )
  end
end
