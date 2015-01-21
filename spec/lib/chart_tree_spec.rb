require 'public_chart_tree'
require 'active_support/core_ext/object/json'

RSpec.describe PublicChartTree do
  subject do
    described_class.new do
      measure_source 'Public Data' do
        path_component 'cms'

        dimensions :MORT_30_AMI_SCORE,
                   :MORT_30_AMI_DENOMINATOR

        bundle 'Value Based Purchasing' do
          domain 'Outcome of Care' do
            category 'Mortality' do
              measure '30 Day Mortality, AMI' do
                dimensions :MORT_30_AMI_SCORE,
                           :MORT_30_AMI_DENOMINATOR,
                           :MORT_30_VBP_SCORE,
                           :MORT_30_VBP_PERFORMANCE,
                           :MORT_30_VBP_ACHIEVEMENT,
                           :MORT_30_VBP_IMPROVEMENT
              end
            end
          end
        end
      end

      measure_source 'Private Data'
    end
  end

  let(:node) { subject.find(path) }
  let(:actual_child_attrs) { node.children.map { |child| actual_attrs(child) } }

  def actual_attrs(child_node)
    child_node.to_h.slice(:short_name)
  end

  context 'at the navigation root' do
    let(:path) { '' }

    it 'returns the children' do
      expect(actual_child_attrs).to eq [
        {
          short_name: 'Public Data',
        },
        {
          short_name: 'Private Data',
        },
      ]
    end
  end

  context 'at a nested node' do
    let(:path) { 'cms' }

    it 'returns the children' do
      expect(actual_child_attrs).to eq [
        {
          short_name: 'Value Based Purchasing',
        },
      ]
    end

    specify do
      expect(node.dimensions).to eq [
        :MORT_30_AMI_SCORE,
        :MORT_30_AMI_DENOMINATOR,
      ]
    end

    specify do
      expect(node.path).to eq 'cms'
    end
  end
end
