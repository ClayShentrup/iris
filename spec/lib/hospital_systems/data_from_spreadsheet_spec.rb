require 'hospital_systems/data_from_spreadsheet'

RSpec.describe HospitalSystems::DataFromSpreadsheet do
  let(:results) { described_class.call }

  before do
    stub_const(
      "#{described_class}::FILEPATH",
      './spec/fixtures/hospital_systems_importer/test_file.xls',
    )
  end

  it 'gets results which have a system name' do
    expect(results.to_a).to eq [
      {
        system_name: 'Universal Health Services',
        provider_id: '200001',
      },
      {
        system_name: 'Health Resources',
        provider_id: '20002F',
      },
      {
        system_name: nil,
        provider_id: '200003',
      },
      {
        system_name: 'Universal Health Services',
        provider_id: '200004',
      },
      {
        system_name: 'Department of Veterans Affairs',
        provider_id: '019048',
      },
    ]
  end

  it 'is lazy' do
    # This allows us to output a counter of rows processed as we go through them
    lazy_enum = results.map { fail }
    expect { lazy_enum.force }.to raise_error RuntimeError
  end
end
