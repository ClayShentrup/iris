require 'hospital_systems/iterator'

RSpec.describe HospitalSystems::Iterator do
  subject { described_class.new(file_path) }
  let(:file_path) { './spec/fixtures/hospital_systems_importer/test_file.xls' }
  let(:results) { subject.to_a }

  it 'gets the exact results' do
    expect(results).to eq [
      {
        system_name: 'Universal Health Services',
        provider_id: '200001',
      },
      {
        system_name: 'Health Resources',
        provider_id: '200002',
      },
      {
        system_name: nil,
        provider_id: '200003',
      },
    ]
  end
end
