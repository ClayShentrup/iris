require 'feature_spec_helper'

RSpec.feature 'Toggling left navigation' do
  login_user

  background do
    resize_to(:mobile)
    visit root_path
  end

  def ensure_sidebar_is_not_visible
    expect(page).to have_css('.sidebar_offcanvas', visible: false)
  end

  def ensure_sidebar_is_visible
    expect(page).to have_css('.sidebar_offcanvas', visible: true)
  end

  feature 'revealing the left navigation on mobile' do
    scenario do
      ensure_sidebar_is_not_visible
      find('.menu_icon').click
      ensure_sidebar_is_visible
    end
  end
end
