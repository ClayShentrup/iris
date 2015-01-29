require 'rails_helper'

RSpec.describe PublicChartsHelper do
  describe '#back_button_options' do
    let(:node) { instance_double(PublicChartTree::Node, parent_id: parent_id) }

    before do
      allow(node).to receive(:parent_is_root?) { parent_id.blank? }
    end

    def options
      helper.back_button_options(node)
    end

    context 'parent is root' do
      let(:parent_id) { '' }

      specify do
        expect(options).to eq(
          controller: :charts_root,
          action: :show,
          only_path: true,
        )
      end
    end

    context 'parent is not root' do
      let(:parent_id) { 'public-data' }

      specify do
        expect(options).to eq(
          controller: :public_charts,
          action: :show,
          id: 'public-data',
          only_path: true,
        )
      end
    end
  end

  describe '#parent_link_text' do
    let(:node) do
      instance_double(PublicChartTree::Node,
                      parent_id: parent_id,
                      parent_short_title: parent_short_title,
      )
    end

    before do
      allow(node).to receive(:parent_is_root?) { parent_id.blank? }
    end

    def parent_link_text
      helper.parent_link_text(node)
    end

    context 'parent is root' do
      let(:parent_id) { '' }
      let(:parent_short_title) { nil }

      specify { expect(parent_link_text).to eq 'Metrics' }
    end

    context 'parent is not root' do
      let(:parent_id) { 'public-data' }
      let(:parent_short_title) { 'Public Data' }

      specify { expect(parent_link_text).to eq parent_short_title }
    end
  end

  describe '#node_link' do
    let(:node) do
      instance_double(PublicChartTree::Node,
                      id: id,
                      short_title: short_title,
      )
    end
    let(:id) { 'public_data/foobar' }
    let(:short_title) { 'Nice Metric' }
    let(:expected_href) { "/measures/#{id}" }
    let(:link) { helper.node_link(node) }
    let(:anchor) { Nokogiri::HTML.parse(link).at_css('a') }

    it 'returns an anchor with a short title' do
      expect(anchor.text).to eq short_title
      expect(anchor[:href]).to eq expected_href
    end
  end
end
