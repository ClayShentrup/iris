require 'feature_spec_helper'

RSpec.feature 'responsive design' do
  login(:user)

  given(:url) do
    %w[
      /
      measures
      public-data
      hospital-acquired-conditions
      hospital-acquired-infection
    ].join('/')
  end

  let(:all_selector_groups) do
    [
      desktop_only_selectors,
      tablet_portrait_selectors,
      mobile_selectors,
    ]
  end

  let(:desktop_only_selectors) do
    [
      '#measures_nav_container .forward_btn',
    ]
  end

  let(:tablet_portrait_selectors) do
    []
  end

  let(:mobile_selectors) do
    []
  end

  def check(*selector_groups)
    hidden_groups = all_selector_groups - selector_groups
    selector_groups.each do |selector_group|
      selector_group.each do
      end
    end
    hidden_groups.each do |hidden_group|
      hidden_group.each do |selector|
        expect(page).not_to have_css selector
      end
    end
  end

  background do
    visit url
    resize_to(width)
  end

  feature 'on desktop' do
    given(:width) { :desktop }

    scenario 'viewing stuff' do
      check(desktop_only_selectors, tablet_portrait_selectors, mobile_selectors)
    end
  end

  feature 'on mobile' do
    given(:width) { :mobile }

    scenario 'viewing stuff' do
      check(desktop_only_selectors, tablet_portrait_selectors)
    end
  end

  feature 'on tablet portrait' do
    given(:width) { :tablet_portrait }

    scenario 'viewing stuff' do
      check(desktop_only_selectors, mobile_selectors)
    end
  end
end
