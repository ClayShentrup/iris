require './app/jobs/import_dimension_samples_job'
RSpec.describe ImportDimensionSamplesJob do
  before do
    stub_const('PUBLIC_CHARTS_TREE', double)
  end

  it 'fetches the logs' do
    expect(PUBLIC_CHARTS_TREE).to receive(:import_all)
    described_class.perform_now
  end
end
