require 'feature_spec_helper'

RSpec.feature 'Toggling left navigation' do
  login_user

  background do
    resize_to(width)
    visit root_path
  end

  def check
    expect(page).to have_css('.sidebar_offcanvas', visible: false)
    find('.menu_icon').click
    expect(page).to have_css('.sidebar_offcanvas', visible: true)
  end

  feature 'revealing the left navigation on mobile' do
    let(:width) { :mobile }

    scenario do
      check
    end
  end

  feature 'revealing the left navigation on tablet portrait' do
    let(:width) { :tablet_portrait }

    scenario do
      check
    end
  end

  feature 'viewing the left navigation on desktop' do
    let(:width) { :desktop }

    scenario do
      expect(page).to have_css('.sidebar_offcanvas', visible: true)
    end
  end
end
