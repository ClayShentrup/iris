require 'feature_spec_helper'

RSpec.feature 'responsive design' do
  login_user
  before do
    enable_feature :navbar_search
  end

  feature 'searches measures' do
    background do
      visit '/'
      resize_to(width)
    end

    feature 'on desktop' do
      given(:width) { :desktop }
      scenario 'dims background on search box focus' do
        main_content = find('.main_content')
        expect(main_content[:style]).to match('')
        find('.search.hide_on_mobile .icon_search').click
        expect(main_content[:style]).to match(/opacity: 0.5/)
        find('.search.hide_on_mobile .icon_close').click
        expect(main_content[:style]).to match('')
      end
    end

    feature 'on mobile' do
      given(:width) { :mobile }

      scenario 'dims background and hides nav buttons on search box focus' do
        main_content = find('.main_content')
        expect(main_content[:style]).to match('')
        find('.search.hide_on_desktop .icon_search').click
        all('.nav_btns').each do |btn|
          expect(btn).not_to be_visible
        end
        expect(main_content[:style]).to match(/opacity: 0.5/)
        find('.search.hide_on_desktop .icon_close').click
        expect(main_content[:style]).to match('')
        all('.nav_btns').each do |btn|
          expect(btn).to be_visible
        end
      end
    end
  end
end
