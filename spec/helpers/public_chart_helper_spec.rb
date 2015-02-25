require 'rails_helper'

RSpec.describe PublicChartsHelper do
  describe '#back_button_options' do
    let(:node) do
      instance_double(PublicChartTree::Node,
                      type: type,
                      parent_id: parent_id,
      )
    end
    let(:parent_id) { 'parent-id' }

    def options
      helper.back_button_options(node)
    end

    context 'parent is root, i.e. node is a measure source' do
      let(:type) { 'measure_source' }

      specify do
        expect(options).to eq(
          controller: :charts_root,
          action: :show,
          only_path: true,
        )
      end
    end

    context 'parent is not root' do
      let(:type) { 'bundle' }

      specify do
        expect(options).to eq(
          controller: :public_charts,
          action: :show,
          id: parent_id,
          only_path: true,
        )
      end
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
    let(:expected_href) { "/metrics/#{id}" }
    let(:link) { helper.node_link(node) }
    let(:anchor) { Nokogiri::HTML.parse(link).at_css('a') }

    it 'returns an anchor with a short title' do
      expect(anchor.text).to eq short_title
      expect(anchor[:href]).to eq expected_href
    end
  end
end
