require 'feature_spec_helper'

RSpec.feature 'responsive design' do
  login(:user)

  given(:url) do
    %w[
      /
      measures
      public-data
      hospital-acquired-conditions
    ].join('/')
  end

  let(:all_selector_groups) do
    [
      elements_visible_on_desktop,
      elements_visible_on_tablet,
      elements_visible_on_mobile,
    ]
  end

  let(:elements_visible_on_desktop) do
    [
      '#measures_nav_container .back_btn_container .parent_node_text',
    ]
  end

  let(:elements_visible_on_tablet) do
    [
      '#measures_nav_container .back_btn_container .current_node_text',
    ]
  end

  let(:elements_visible_on_mobile) do
    [
      '#measures_nav_container .forward_btn',
    ]
  end

  def check
    hidden_groups = all_selector_groups - selector_groups
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

  background do
    visit url
    resize_to(width)
    check
  end

  feature 'on mobile' do
    given(:width) { :mobile }
    given(:selector_groups) do
      [
        elements_visible_on_mobile,
        elements_visible_on_tablet,
      ]
    end

    scenario 'viewing stuff' do
      check
    end
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
        elements_visible_on_mobile,
      ]
    end

    scenario 'viewing stuff' do
      check
    end
  end
end
