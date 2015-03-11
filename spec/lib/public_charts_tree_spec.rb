require 'public_charts_tree'
require 'dimension_sample_managers/socrata'
require 'socrata/datasets/hospital_value_based_purchasing'

RSpec.describe PublicChartsTree do
  subject { find(node_id) }

  let(:providers) { double('providers relation') }
  let(:tree) do
    described_class.new do
      measure_source 'Public Data' do
        bundle 'Value Based Purchasing' do
          value VALUE_DIMENSION_SAMPLE_MANAGER
          domain 'Outcome of Care' do
            value VALUE_DIMENSION_SAMPLE_MANAGER
            category 'Mortality' do
              measures :MORT_30_AMI,
                       :MORT_30_HF
            end
          end
        end
      end

      measure_source 'Private Data'
    end
  end
  let(:value_dimension_sample_manager) do
    instance_double(DimensionSampleManagers::Socrata)
  end
  let(:measures) do
    {
      MORT_30_HF: mort_30_hf.to_h,
      MORT_30_AMI: mort_30_ami.to_h,
    }
  end
  let(:mort_30_ami) do
    OpenStruct.new(
      short_title: 'Acute Myocardial Infarction Mortality',
      long_title: 'Acute Myocardial Infarction 30-day Mortality Rate',
      value: value_dimension_sample_manager,
    )
  end
  let(:mort_30_hf) do
    OpenStruct.new(
      short_title: 'Heart Failure Mortality',
      long_title: 'Heart Failure 30-day Mortality Rate',
      value: value_dimension_sample_manager,
    )
  end
  let(:expected_data) do
    {
      bars: [],
    }
  end

  def bundles
    %w[value-based-purchasing]
  end

  def find(node_id)
    tree.find_node(node_id, providers: providers, bundles: bundles)
  end

  before do
    stub_const('MEASURES', measures)
    stub_const('VALUE_DIMENSION_SAMPLE_MANAGER', value_dimension_sample_manager)
  end

  describe '#refresh' do
    it 'refreshes all dimension sample managers' do
      expect(value_dimension_sample_manager).to receive(:refresh)
        .exactly(4).times
      tree.refresh
    end
  end

  context 'at the navigation root' do
    let(:node_id) { '' }

    specify { expect(subject.id).to eq node_id }

    it 'returns the children' do
      expect(subject.children).to eq [
        find('public-data'),
        find('private-data'),
      ]
    end
  end

  let(:expected_breadcrumbs) do
    [
      subject.parent_short_title,
      subject.short_title,
    ]
  end

  shared_examples 'a child node' do
    specify { expect(subject.id).to eq node_id }

    it 'returns the children' do
      actual_child_ids = subject.children.map(&:id)
      expect(actual_child_ids).to eq expected_child_ids
    end

    specify { expect(subject.breadcrumbs).to eq expected_breadcrumbs }
    specify { expect(subject.short_title).to eq expected_short_title }
    specify { expect(subject.parent_id).to eq expected_parent_id }
    specify { expect(subject.type).to eq expected_type }
  end

  shared_examples 'a chart node' do
    it_behaves_like 'a child node'

    describe '#data' do
      let(:values) do
        [
          '17.888',
          '13.1250000000',
          '9.75',
        ]
      end
      let(:expected_data) do
        {
          bars: values.map { |value| { value: value } },
        }
      end

      before do
        allow(value_dimension_sample_manager).to receive(:data).with(providers)
          .and_return(values)
      end

      it 'returns data for the specified providers' do
        expect(subject.data).to eq expected_data
      end
    end
  end

  context 'at a measure source node' do
    let(:node_id) { 'public-data' }
    let(:expected_short_title) { 'Public Data' }
    let(:expected_parent_id) { '' }
    let(:expected_type) { 'measure_source' }
    let(:expected_child_ids) { ['public-data/value-based-purchasing'] }
    let(:expected_breadcrumbs) { [subject.short_title] }
    let(:private_data) { tree.find('private-data') }

    it_behaves_like 'a child node'
  end

  context 'at a bundle node' do
    let(:parent_id) { 'public-data' }
    let(:node_id) { "#{parent_id}/value-based-purchasing" }
    let(:expected_short_title) { 'Value Based Purchasing' }
    let(:expected_parent_id) { 'public-data' }
    let(:expected_type) { 'bundle' }
    let(:expected_child_ids) do
      %w[
        public-data/value-based-purchasing/outcome-of-care
      ]
    end

    it_behaves_like 'a chart node'

    specify { expect(subject.parent_short_title).to eq 'Public Data' }
  end

  context 'at a domain node' do
    let(:expected_parent_id) { 'public-data/value-based-purchasing' }
    let(:node_id) { "#{expected_parent_id}/outcome-of-care" }
    let(:expected_short_title) { 'Outcome of Care' }
    let(:expected_type) { 'domain' }
    let(:expected_child_ids) do
      ['public-data/value-based-purchasing/outcome-of-care/mortality']
    end

    it_behaves_like 'a chart node'

    specify do
      expect(subject.parent_short_title).to eq 'Value Based Purchasing'
    end
  end

  context 'at a category node' do
    let(:expected_parent_id) do
      'public-data/value-based-purchasing/outcome-of-care'
    end
    let(:node_id) { "#{expected_parent_id}/mortality" }
    let(:expected_short_title) { 'Mortality' }
    let(:expected_type) { 'category' }
    let(:mort_30_ami_id) do
      "#{expected_parent_id}/mortality/acute-myocardial-infarction-mortality"
    end
    let(:mort_30_hf_id) do
      "#{expected_parent_id}/mortality/heart-failure-mortality"
    end
    let(:expected_child_ids) do
      [
        mort_30_ami_id,
        mort_30_hf_id,
      ]
    end

    it_behaves_like 'a child node'

    specify { expect(subject.parent_short_title).to eq 'Outcome of Care' }
  end

  context 'at a measure node' do
    let(:expected_parent_id) do
      %w[
        public-data
        value-based-purchasing
        outcome-of-care
        mortality
      ].join('/')
    end
    let(:expected_short_title) { measure.short_title }
    let(:expected_type) { 'measure' }
    let(:expected_child_ids) { [] }

    shared_examples 'a mortality measure node' do
      specify do
        expect(subject.long_title).to eq measure.long_title
      end
      specify { expect(subject.parent_short_title).to eq 'Mortality' }
    end

    describe 'MORT_30_AMI' do
      let(:measure) { mort_30_ami }
      let(:node_id) do
        "#{expected_parent_id}/acute-myocardial-infarction-mortality"
      end
      it_behaves_like 'a mortality measure node'
      it_behaves_like 'a chart node'
    end

    describe 'MORT_30_HF' do
      let(:measure) { mort_30_hf }
      let(:node_id) { "#{expected_parent_id}/heart-failure-mortality" }
      it_behaves_like 'a mortality measure node'
      it_behaves_like 'a child node'
    end
  end

  context 'with an invalid identifier' do
    let(:node_id) { 'fake_path' }

    it 'raises an exception' do
      expect { subject }.to raise_error(
        PublicChartsTree::PublicChartNotFoundError,
      )
    end
  end

  describe 'search' do
    let(:result) { measure_source.search(search_term) }
    let(:measure_source) { find('public-data') }

    def returns_expected_results
      expect(result.to_h).to eq expected_result
    end

    context 'within the same bundle' do
      let(:vbp_bundle_node) { find('public-data/value-based-purchasing') }

      context 'match on bundle' do
        let(:search_term) { 'VaLuE bAs' }
        let(:expected_result) do
          {
            short_title: 'Public Data',
            children: [
              {
                short_title: 'Value Based Purchasing',
                children: [],
              },
            ],
          }
        end
        let(:expected_bundle_node) { find(node_id) }

        it { returns_expected_results }
      end

      context 'match on domain' do
        let(:outcome_of_care_domain_node) do
          find('public-data/value-based-purchasing/outcome-of-care')
        end
        let(:search_term) { 'Outcome' }
        let(:expected_result) do
          {
            short_title: 'Public Data',
            children: [
              {
                short_title: 'Value Based Purchasing',
                children: [
                  {
                    short_title: 'Outcome of Care',
                    children: [],
                  },
                ],
              },
            ],
          }
        end

        it { returns_expected_results }
      end
    end
  end
end
