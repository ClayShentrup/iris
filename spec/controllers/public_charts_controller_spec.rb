require 'rails_helper'

RSpec.describe PublicChartsController do
  let(:current_user) do
    create(User, :authenticatable, :confirmed, :with_associations)
  end

  before do
    sign_in current_user
  end

  describe 'GET show' do
    let(:public_charts_tree) do
      PublicChartsTree.new do
        measure_source 'Socrata' do
          metric_module 'Value Based Purchasing' do
            domain 'Outcome of Care' do
              measure 'Uno'
              measure 'Dos'
              measure 'Tres'
            end
            domain 'Efficiency of Care'
          end
        end
      end
    end
    let(:some_providers) { providers_relation(0) }
    let!(:node) do
      public_charts_tree.find_node(
        node_id,
        providers: some_providers,
      )
    end
    let(:default_provider) { create(:provider) }

    def providers_relation(count)
      create_list(Provider, count)
      Provider.in_same_city(default_provider)
    end

    before do
      stub_const('PUBLIC_CHARTS_TREE', public_charts_tree)
      get :show, id: node_id
    end

    describe 'assigned node' do
      let(:node_id) { 'socrata' }
      let(:some_providers) { providers_relation(2).limit(10) }

      it 'it sets the node' do
        expect(assigns(:node)).to eq node
      end
    end

    context 'Socrata' do
      let(:node_id) { 'socrata' }
      save_fixture
      specify { expect(response).to be_success }
    end

    describe 'metrics navigation' do
      subject { response.body }
      let(:measures_nav_container) { '#measures_nav_container' }

      context 'for measures' do
        let(:node_id) do
          %w[
            socrata
            value-based-purchasing
            outcome-of-care
            dos
          ].join('/')
        end

        it 'shows grandparent' do
          is_expected.to have_css(
            measures_nav_container,
            text: 'Dos',
          )
        end

        it 'shows sibling measures' do
          is_expected.to have_css(measures_nav_container, text: 'Uno')
          is_expected.to have_css(measures_nav_container, text: 'Tres')
        end

        it 'does not show right arrow or link for current node' do
          is_expected.to have_css(
            '.measures_nav_current_node',
            text: 'Dos',
          )
          is_expected.not_to have_css '.measures_nav_current_node a'
          is_expected.not_to have_css '.measures_nav_current_node svg'
        end

        it 'shows sibling measure with link and no arrow' do
          forward_btn = '.measures_nav_btn.forward_btn'
          is_expected.to have_css(forward_btn, text: 'Uno')
          is_expected.to have_css "#{forward_btn} a"
          is_expected.not_to have_css "#{forward_btn} svg"
        end
      end

      context 'for non-measures' do
        let(:node_id) do
          %w[
            socrata
            value-based-purchasing
            outcome-of-care
          ].join('/')
        end

        it 'shows the current node' do
          is_expected.to have_css(
            measures_nav_container,
            text: 'Outcome of Care',
          )
        end

        it 'does not show sibling nodes' do
          is_expected.not_to have_css(
            measures_nav_container,
            text: 'Efficiency of Care',
          )
        end

        it 'shows child nodes' do
          is_expected.to have_css(measures_nav_container, text: 'Uno')
          is_expected.to have_css(measures_nav_container, text: 'Dos')
          is_expected.to have_css(measures_nav_container, text: 'Tres')
        end

        it 'does not show grandparent' do
          is_expected.not_to have_css(
            measures_nav_container,
            text: 'Socrata',
          )
        end
      end
    end

    context 'with parameters' do
      let(:provider) { create(Provider) }
      let(:node_id) { 'socrata' }
      let(:get_params) { {} }

      before do
        get :show, { id: node_id }.merge(get_params)
      end

      context 'with selected provider id' do
        let(:get_params) { { provider_id: provider.id } }

        it 'persists selected provider' do
          expect(current_user.selected_provider_id).to eq provider.id.to_s
        end

        it 'sets context to city' do
          expect(current_user.selected_context).to eq 'city'
        end
      end

      context 'with selected provider id and comparison context' do
        let(:get_params) { { provider_id: provider.id, context: 'state' } }

        it 'persists selected provider' do
          expect(current_user.selected_provider_id).to eq provider.id.to_s
        end

        it 'persists selected context' do
          expect(current_user.selected_context).to eq 'state'
        end
      end

      context 'with comparison context' do
        let(:get_params) { { context: 'state' } }

        it 'keeps selected provider' do
          expect(current_user.selected_provider_id).to eq nil
        end

        it 'persists selected context' do
          expect(current_user.selected_context).to eq 'state'
        end
      end
    end
  end
end
