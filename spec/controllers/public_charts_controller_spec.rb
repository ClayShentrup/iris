require 'rails_helper'

RSpec.describe PublicChartsController do
  describe 'GET show' do
    login_user

    let(:chart_id) do
      %w[
        public-data
        value-based-purchasing
        outcome-of-care
        mortality
        pneumonia-mortality
      ].join('/')
    end

    describe 'metrics navigation' do
      subject { response.body }

      let(:measures_nav_container) { '#measures_nav_container' }

      context 'for measures' do
        before { get :show, id: chart_id }

        it 'shows sibling measures' do
          is_expected.to have_css(
            measures_nav_container,
            text: 'Heart Failure Mortality',
          )
          is_expected.to have_css(
            measures_nav_container,
            text: 'Acute Myocardial Infarction Mortality',
          )
          is_expected.to have_css(
            measures_nav_container,
            text: 'Pneumonia Mortality',
          )
        end

        it 'does not show right arrow or link for current node' do
          is_expected.to have_css(
            '.measures_nav_current_node',
            text: 'Pneumonia Mortality',
          )
          is_expected.not_to have_css '.measures_nav_current_node a'
          is_expected.not_to have_css '.measures_nav_current_node svg'
        end

        it 'shows sibling measure with link and no arrow' do
          forward_btn = '.measures_nav_btn.forward_btn'
          is_expected.to have_css(forward_btn, text: 'Heart Failure Mortality')
          is_expected.to have_css "#{forward_btn} a"
          is_expected.not_to have_css "#{forward_btn} svg"
        end
      end

      context 'for non-measures' do
        before { get :show, id: 'public-data/value-based-purchasing' }

        it 'shows the current node' do
          is_expected.to have_css(
            measures_nav_container,
            text: 'Value Based Purchasing',
          )
        end

        it 'does not show sibling nodes' do
          is_expected.not_to have_css(
            measures_nav_container,
            text: 'Hospital Acquired Conditions',
          )
        end

        it 'shows child nodes' do
          is_expected.to have_css(
            measures_nav_container,
            text: 'Outcome of Care',
          )
        end
      end
    end

    save_fixture 'for_public-data' do
      get :show, id: 'public-data'
    end

    specify do
      get :show, id: chart_id
      expect(response).to be_success
    end
  end
end
