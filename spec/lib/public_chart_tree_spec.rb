require 'public_chart_tree'
require 'active_support/core_ext/object/json'

RSpec.describe PublicChartTree do
  subject { tree.find(id) }

  let(:tree) do
    described_class.new do
      measure_source 'Public Data' do
        id_component 'cms'

        dimensions :MORT_30_AMI_SCORE,
                   :MORT_30_AMI_DENOMINATOR

        bundle 'Value Based Purchasing' do
          domain 'Outcome of Care' do
            category 'Mortality' do
              dimensions :MORT_30_AMI_SCORE,
                         :MORT_30_AMI_DENOMINATOR

              measure '30 Day Mortality, AMI'
            end
          end
        end
      end

      measure_source 'Private Data'
    end
  end

  context 'at the navigation root' do
    let(:id) { '' }

    specify { expect(subject.id).to eq id }

    it 'returns the children' do
      expect(subject.children).to eq [
        tree.find('cms'),
        tree.find('private-data'),
      ]
    end

    it 'has no breadcrumbs' do
      expect(subject.breadcrumbs).to eq []
    end
  end

  context 'at a nested subject' do
    let(:id) { 'cms/value-based-purchasing/outcome-of-care/mortality' }

    specify { expect(subject.id).to eq id }

    it 'returns the children' do
      expect(subject.children).to eq [
        tree.find([
          id,
          '30-day-mortality-ami',
        ].join('/')),
      ]
    end

    specify do
      expect(subject.dimensions).to eq [
        :MORT_30_AMI_SCORE,
        :MORT_30_AMI_DENOMINATOR,
      ]
    end

    specify do
      expect(subject.breadcrumbs).to eq [
        'Public Data',
        'Value Based Purchasing',
        'Outcome of Care',
        'Mortality',
      ]
    end
  end
end
