require 'rails_helper'

RSpec.describe PublicChartsHelper do
  describe '#back_button_options' do
    def options
      helper.back_button_options(parent_id)
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
end
