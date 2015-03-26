require './app/jobs/dimension_sample_manager_import_job'

RSpec.describe DimensionSampleManagerImportJob do
  let(:required_args) do
    {
      dimension_samples: [],
      model_attributes: {},
      model_class_string: 'model_class_string',
      rename_hash: {},
      value_column_name: 'fake_score',
    }
  end

  before do
    stub_const('Socrata::DimensionSampleImporter', double)
  end

  it 'imports dimension samples' do
    expect(Socrata::DimensionSampleImporter).to receive(:call)
    described_class.perform_now(required_args)
  end
end
