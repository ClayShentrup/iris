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
  end

  context 'at a node directly under the root node' do
    let(:id) { 'cms' }

    it 'has only itself as a breadcrumb' do
      expect(subject.breadcrumbs).to eq [subject]
    end
  end

  context 'at a nested subject' do
    let(:parent_id) { 'cms/value-based-purchasing/outcome-of-care' }
    let(:id) { "#{parent_id}/mortality" }

    specify { expect(subject.id).to eq id }

    it 'returns the children' do
      expect(subject.children).to eq [
        tree.find("#{id}/30-day-mortality-ami"),
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
        tree.find(parent_id),
        subject,
      ]
    end
  end
end
