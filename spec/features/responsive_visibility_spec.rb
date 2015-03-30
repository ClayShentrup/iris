require 'feature_spec_helper'

RSpec.feature 'responsive design' do
  login_user

  given(:url) do
    %w[
      /
      metrics
      public-data
      hospital-acquired-conditions
    ].join('/')
  end

  let(:all_selector_groups) do
    [
      elements_visible_on_desktop,
      elements_visible_on_tablet,
    ]
  end

  let(:elements_visible_on_desktop) { ['#left_nav'] }

  let(:elements_visible_on_tablet) { ['.menu_icon'] }

  def check
    selector_groups.each do |selector_group|
      selector_group.each do |selector|
        expect(page).to have_css selector
      end
    end
    hidden_groups.each do |hidden_group|
      hidden_group.each do |selector|
        expect(page).not_to have_css selector
      end
    end
  end

  def hidden_groups
    all_selector_groups - selector_groups
  end

  background do
    visit url
    resize_to(width)
  end

  feature 'on tablet portrait' do
    given(:width) { :tablet_portrait }
    given(:selector_groups) do
      [
        elements_visible_on_tablet,
        elements_visible_on_desktop,
      ]
    end

    scenario 'viewing stuff' do
      check
    end
  end

  feature 'on desktop' do
    given(:width) { :desktop }
    given(:selector_groups) do
      [
        elements_visible_on_desktop,
      ]
    end

    scenario 'viewing stuff' do
      check
    end
  end
end
