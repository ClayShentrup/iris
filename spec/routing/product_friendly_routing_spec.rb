require 'rails_helper'

RSpec.describe 'Product Friendly Routes' do
  let(:root) { '/metrics/cms' }
  let(:prefix) { "#{root}/#{bundle}/#{domain}" }

  context 'VBP bundle' do
    let(:bundle) { 'value-based-purchasing' }
    context 'outcome-of-care' do
      let(:domain) { 'outcome-of-care' }
      specify do
        expect(
          get: "#{prefix}/30-day-mortality-ami",
        ).to route_to(
          'category_measures#show',
          category_measure_id: '30-day-mortality-ami',
        )
      end

      specify do
        expect(
          get: "#{prefix}/30-day-mortality-heart-failure",
        ).to route_to(
          'category_measures#show',
          category_measure_id: '30-day-mortality-heart-failure',
        )
      end

      specify do
        expect(
          get: "#{prefix}/30-day-mortality-pneumonia",
        ).to route_to(
          'category_measures#show',
          category_measure_id: '30-day-mortality-pneumonia',
        )
      end
    end
  end
end
