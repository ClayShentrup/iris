require 'dimension_samples_getter/single_measure'

RSpec.describe DimensionSamplesGetter::SingleMeasure do
  subject do
    described_class.new(
      dataset_id: dataset_id,
      column_name: column_name,
    )
  end
  let(:dataset_id) { 'ypbt-wvdk' }
  let(:column_name) { 'weighted_outcome_domain_score' }
  let(:providers) { 'a providers relation' }
  let(:data) { :some_data }

  before do
    stub_const(
      'DimensionSample::SingleMeasure',
      class_double('DimensionSample::SingleMeasure'),
    )
    allow(DimensionSample::SingleMeasure).to receive(:data).with(
      column_name: column_name,
      dataset_id: dataset_id,
      providers: providers,
    ).and_return(data)
  end

  it 'works' do
    expect(subject.data(providers)).to be data
  end
end
