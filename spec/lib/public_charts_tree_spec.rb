require 'public_charts_tree'
require 'socrata/dimension_sample_managers/graph_data_points/provider_aggregate'

RSpec.describe PublicChartsTree do
  subject { find(node_id) }

  let(:providers) { double('providers relation') }
  let(:tree) do
    described_class.new do
      measure_source 'Public Data' do
        metric_module 'Value Based Purchasing' do
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
    instance_double(Socrata::DimensionSampleManagers::GraphDataPoints::
      ProviderAggregate)
  end
  let(:measures) do
    {
      MORT_30_HF: mort_30_hf.to_h,
      MORT_30_AMI: mort_30_ami.to_h,
    }
  end
  let(:mort_30_ami) do
    OpenStruct.new(
      title: 'Acute Myocardial Infarction Mortality',
      value: value_dimension_sample_manager,
    )
  end
  let(:mort_30_hf) do
    OpenStruct.new(
      title: 'Heart Failure Mortality',
      value: value_dimension_sample_manager,
    )
  end
  let(:expected_data) do
    {
      bars: [],
    }
  end
  let(:mort_30_ami_dsm) do
    instance_double(Socrata::DimensionSampleManagers::GraphDataPoints::Measure)
  end
  let(:mort_30_hf_dsm) do
    instance_double(Socrata::DimensionSampleManagers::GraphDataPoints::Measure)
  end

  def find(node_id)
    tree.find_node(node_id, providers: providers)
  end

  before do
    stub_const('MEASURES', measures)
    stub_const('VALUE_DIMENSION_SAMPLE_MANAGER', value_dimension_sample_manager)
    allow(Socrata::DimensionSampleManagers::GraphDataPoints::Measure)
      .to receive(:new).with(measure_id: :MORT_30_AMI)
      .and_return(mort_30_ami_dsm)
    allow(Socrata::DimensionSampleManagers::GraphDataPoints::Measure)
      .to receive(:new).with(measure_id: :MORT_30_HF)
      .and_return(mort_30_hf_dsm)
  end

  describe '#import' do
    it 'imports all dimension sample managers' do
      expect(value_dimension_sample_manager).to receive(:import)
        .exactly(2).times
      expect(mort_30_ami_dsm).to receive(:import)
      expect(mort_30_hf_dsm).to receive(:import)
      tree.import_all
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
      subject.parent_title,
      subject.title,
    ]
  end

  shared_examples 'a child node' do
    specify { expect(subject.id).to eq node_id }

    it 'returns the children' do
      actual_child_ids = subject.children.map(&:id)
      expect(actual_child_ids).to eq expected_child_ids
    end

    specify { expect(subject.breadcrumbs).to eq expected_breadcrumbs }
    specify { expect(subject.title).to eq expected_title }
    specify { expect(subject.parent_id).to eq expected_parent_id }
    specify { expect(subject.type).to eq expected_type }
    specify { expect(subject.id_component).to eq expected_id_component }
  end

  shared_examples 'a chart node' do
    it_behaves_like 'a child node'

    describe '#data' do
      let(:values_and_provider_names) do
        [
          [
            '17.888',
            'Hospital 1',
          ],
          [
            '13.1250000000',
            'Hospital 2',
          ],
          [
            '9.75',
            'Hospital 3',
          ],
        ]
      end
      let(:expected_data) do
        {
          bars: values_and_provider_names.map do |value, provider_name|
            {
              value: value,
              tooltip: {
                provider_name: provider_name,
              },
            }
          end,
          title: subject.title,
        }
      end

      before do
        allow(value_dimension_sample_manager).to receive(:data).with(providers)
          .and_return(values_and_provider_names)
      end

      it 'returns data for the specified providers' do
        expect(subject.data).to eq expected_data
      end
    end
  end

  context 'at a measure source node' do
    let(:node_id) { 'public-data' }
    let(:expected_title) { 'Public Data' }
    let(:expected_parent_id) { '' }
    let(:expected_type) { 'measure_source' }
    let(:expected_child_ids) { ['public-data/value-based-purchasing'] }
    let(:expected_breadcrumbs) { [subject.title] }
    let(:private_data) { tree.find('private-data') }
    let(:expected_id_component) { 'public-data' }

    it_behaves_like 'a child node'
  end

  context 'at a metric module node' do
    let(:parent_id) { 'public-data' }
    let(:expected_id_component) { 'value-based-purchasing' }
    let(:node_id) { "#{parent_id}/#{expected_id_component}" }
    let(:expected_title) { 'Value Based Purchasing' }
    let(:expected_parent_id) { 'public-data' }
    let(:expected_type) { 'metric_module' }
    let(:expected_child_ids) do
      %w[
        public-data/value-based-purchasing/outcome-of-care
      ]
    end

    it_behaves_like 'a chart node'

    specify { expect(subject.parent_title).to eq 'Public Data' }
  end

  context 'at a domain node' do
    let(:expected_parent_id) { 'public-data/value-based-purchasing' }
    let(:expected_id_component) { 'outcome-of-care' }
    let(:node_id) { "#{expected_parent_id}/#{expected_id_component}" }
    let(:expected_title) { 'Outcome of Care' }
    let(:expected_type) { 'domain' }
    let(:expected_child_ids) do
      ['public-data/value-based-purchasing/outcome-of-care/mortality']
    end

    it_behaves_like 'a chart node'

    specify do
      expect(subject.parent_title).to eq 'Value Based Purchasing'
    end
  end

  context 'at a category node' do
    let(:expected_parent_id) do
      'public-data/value-based-purchasing/outcome-of-care'
    end
    let(:expected_id_component) { 'mortality' }
    let(:node_id) { "#{expected_parent_id}/#{expected_id_component}" }
    let(:expected_title) { 'Mortality' }
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

    specify { expect(subject.parent_title).to eq 'Outcome of Care' }
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
    let(:expected_title) { measure.title }
    let(:expected_type) { 'measure' }
    let(:expected_child_ids) { [] }

    shared_examples 'a mortality measure node' do
      specify { expect(subject.parent_title).to eq 'Mortality' }
    end

    describe 'MORT_30_AMI' do
      let(:value_dimension_sample_manager) { mort_30_ami_dsm }
      let(:measure) { mort_30_ami }
      let(:expected_id_component) { 'acute-myocardial-infarction-mortality' }
      let(:node_id) do
        "#{expected_parent_id}/#{expected_id_component}"
      end
      it_behaves_like 'a mortality measure node'
      it_behaves_like 'a chart node'
    end

    describe 'MORT_30_HF' do
      let(:value_dimension_sample_manager) { mort_30_hf_dsm }
      let(:measure) { mort_30_hf }
      let(:expected_id_component) { 'heart-failure-mortality' }
      let(:node_id) { "#{expected_parent_id}/#{expected_id_component}" }
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

    context 'within the same metric module' do
      let(:vbp_metric_module_node) do
        find('public-data/value-based-purchasing')
      end

      context 'match on metric_module' do
        let(:search_term) { 'VaLuE bAs' }
        let(:expected_result) do
          {
            title: 'Public Data',
            children: [
              {
                title: 'Value Based Purchasing',
                children: [],
              },
            ],
          }
        end
        let(:expected_metric_module_node) { find(node_id) }

        it { returns_expected_results }
      end

      context 'match on domain' do
        let(:outcome_of_care_domain_node) do
          find('public-data/value-based-purchasing/outcome-of-care')
        end
        let(:search_term) { 'Outcome' }
        let(:expected_result) do
          {
            title: 'Public Data',
            children: [
              {
                title: 'Value Based Purchasing',
                children: [
                  {
                    title: 'Outcome of Care',
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
