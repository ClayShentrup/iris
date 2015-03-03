require 'rails_helper'

RSpec.describe PublicChartsController do
  describe 'GET show' do
    login_user

    let(:all_hospitals) { Hospital.all }
    let!(:node) do
      PUBLIC_CHARTS_TREE.find_node(node_id, providers: all_hospitals)
    end

    before do
      allow(PUBLIC_CHARTS_TREE).to receive(:find_node).with(
        node_id,
        providers: all_hospitals,
      ).and_return(node)
      get :show, id: node_id
      expect(response).to be_success
    end

    describe 'assigned node' do
      let(:node_id) { 'public-data' }
      let!(:all_hospitals) { create_list(Hospital, 2) }

      it 'it sets the node' do
        expect(assigns(:node)).to eq node
      end
    end

    context 'Public Data' do
      let(:node_id) { 'public-data' }
      save_fixture
      specify { expect(response).to be_success }
    end

    describe 'metrics navigation' do
      subject { response.body }
      let(:measures_nav_container) { '#measures_nav_container' }

      context 'for measures' do
        context 'Pneumonia Mortality measure' do
          let(:node_id) do
            %w[
              public-data
              value-based-purchasing
              outcome-of-care
              mortality
              pneumonia-mortality
            ].join('/')
          end

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
            is_expected.to have_css(
              forward_btn,
              text: 'Heart Failure Mortality',
            )
            is_expected.to have_css "#{forward_btn} a"
            is_expected.not_to have_css "#{forward_btn} svg"
          end
        end
      end

      context 'for non-measures' do
        let(:node_id) { 'public-data/value-based-purchasing' }

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
  end
end
