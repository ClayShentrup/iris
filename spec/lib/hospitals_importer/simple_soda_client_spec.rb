require 'hospitals_importer/simple_soda_client'
require 'support/vcr_setup'

RSpec.describe HospitalsImporter::SimpleSodaClient, :vcr do
  subject { described_class.new(dataset_id: 'xubh-q36u') }

  it 'gets records for the specified page' do
    expect(subject.get(offset: 2).map(&:to_h)).to eq [
      {
        'hospital_name' => 'ELIZA COFFEE MEMORIAL HOSPITAL',
        'zip_code' => '35631',
        'provider_id' => '010006',
        'state' => 'AL',
        'hospital_type' => 'Acute Care Hospitals',
        'city' => 'FLORENCE',
      },
      {
        'hospital_name' => 'MIZELL MEMORIAL HOSPITAL',
        'zip_code' => '36467',
        'provider_id' => '010007',
        'state' => 'AL',
        'hospital_type' => 'Acute Care Hospitals',
        'city' => 'OPP',
      },
      {
        'hospital_name' => 'CRENSHAW COMMUNITY HOSPITAL',
        'zip_code' => '36049',
        'provider_id' => '010008',
        'state' => 'AL',
        'hospital_type' => 'Acute Care Hospitals',
        'city' => 'LUVERNE',
      }
    ]
  end
end
