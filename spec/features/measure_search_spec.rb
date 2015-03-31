require 'feature_spec_helper'

RSpec.feature 'measure search bar' do
  login_user

  def ensure_initial_page_state
    ensure_inner_content_is_opaque
    ensure_nav_btns_are_visible
  end

  def ensure_inner_content_is_opaque
    expect(find('.inner_content')[:style]).to match('')
  end

  def ensure_inner_content_is_transparent
    expect(find('.inner_content')[:style]).to match(/opacity: 0.5/)
  end

  def ensure_nav_btns_are_visible
    all('.nav_btns').each do |btn|
      expect(btn).to be_visible
    end
  end

  def ensure_nav_btns_not_visible
    all('.nav_btns').each do |btn|
      expect(btn).not_to be_visible
    end
  end

  def open_search
    find('.search .icon_search').click
    ensure_inner_content_is_transparent
    ensure_nav_btns_not_visible
  end

  def close_search
    find('.search .icon_close').click
    ensure_inner_content_is_opaque
    ensure_nav_btns_are_visible
  end

  def check
    ensure_initial_page_state
    open_search
    close_search
    ensure_initial_page_state
  end

  background do
    resize_to(width)
    visit '/'
  end

  feature 'on mobile' do
    given(:width) { :mobile }

    scenario 'changes background opacity and nav button visibility' do
      expect(page).not_to have_css '.hide_on_mobile'
      check
    end
  end

  feature 'on tablet portrait' do
    given(:width) { :tablet_portrait }

    scenario 'changes background opacity and nav button visibility' do
      expect(page).not_to have_css '.hide_on_tablet_portrait'
      check
    end
  end

  feature 'on desktop' do
    given(:width) { :desktop }

    scenario 'changes background opacity and nav button visibility' do
      expect(page).not_to have_css '.hide_on_desktop'
      check
    end
  end
end
