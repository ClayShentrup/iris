require 'active_record_no_rails_helper'
require 'hospital_systems/importer'

RSpec.describe HospitalSystems::Importer do
  let!(:provider_in_universal_system) do
    create(:provider, socrata_provider_id: '200001')
  end

  let!(:provider_in_resources_system) do
    create(:provider, socrata_provider_id: '20002F')
  end

  let!(:provider_without_system) do
    create(:provider, socrata_provider_id: '200003')
  end

  let(:universal_system_name) { 'Universal Health Services' }
  let(:resources_system_name) { 'Health Resources' }

  def import_hospital_systems
    described_class.call.force
  end

  before do
    stub_const(
      'HospitalSystems::DataFromSpreadsheet::FILEPATH',
      './spec/fixtures/hospital_systems_importer/test_file.xls',
    )
  end

  context 'no hospital systems were loaded before' do
    it 'creates new systems' do
      expect { import_hospital_systems }.to change(HospitalSystem, :count).by(2)
    end

    it 'associates provider with systems' do
      import_hospital_systems

      universal_system = provider_in_universal_system.reload.hospital_system
      resources_system = provider_in_resources_system.reload.hospital_system

      expect(universal_system.name).to eq(universal_system_name)
      expect(resources_system.name).to eq(resources_system_name)
    end

    it 'leaves the provider without system if it is not provided' do
      import_hospital_systems

      expect(provider_without_system.reload.hospital_system).to be_nil
    end
  end

  context 'with hospital systems already created' do
    let!(:universal_system) do
      create(:hospital_system, name: 'Universal Health Services')
    end

    let!(:resources_system) do
      create(
        :hospital_system,
        name: 'Health Resources',
        providers: [provider_in_resources_system],
      )
    end

    let!(:healthcare_system) do
      create(
        :hospital_system,
        name: 'Healthcare System',
        providers: [provider_without_system],
      )
    end

    it 'does not create new systems' do
      expect { import_hospital_systems }.not_to change { HospitalSystem.count }
    end

    it 'associates provider with systems' do
      import_hospital_systems
      universal_system = provider_in_universal_system.reload.hospital_system
      resources_system = provider_in_resources_system.reload.hospital_system

      expect(universal_system.name).to eq(universal_system_name)
      expect(resources_system.name).to eq(resources_system_name)
    end

    it 'leaves the provider without system if it is not provided' do
      import_hospital_systems

      expect(provider_without_system.reload.hospital_system).to be_nil
    end

    it 'removes provider from the system not included in the file' do
      import_hospital_systems

      expect(healthcare_system.reload.providers).to be_empty
    end
  end

  context 'with block to handle output messages' do
    let(:messages) { [] }

    it 'passes a warning indicating that one provider was not found' do
      described_class.call.each { |message| messages << message }
      expect(messages).to eq [
        nil,
        nil,
        nil,
        'Provider not found: #200004',
        'Provider not found: #019048',
      ]
    end
  end
end
