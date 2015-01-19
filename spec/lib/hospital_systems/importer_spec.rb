require 'active_record_spec_helper'

require './app/models/hospital'
require './app/models/hospital_system'

require 'hospital_systems/importer'

RSpec.describe HospitalSystems::Importer do
  let(:file_path) { './spec/fixtures/hospital_systems_importer/test_file.xls' }

  let!(:hospital_in_universal_system) do
    create(:hospital, :without_hospital_system, provider_id: '200001')
  end

  let!(:hospita_in_resources_system) do
    create(:hospital, :without_hospital_system, provider_id: '200002')
  end

  let!(:hospital_without_system) do
    create(:hospital, :without_hospital_system, provider_id: '200003')
  end

  let(:universal_system_name) { 'Universal Health Services' }
  let(:resources_system_name) { 'Health Resources' }

  def import_hospital_systems
    described_class.call(file_path)
  end

  context 'no hospital systems were loaded before' do
    it 'creates new systems' do
      expect { import_hospital_systems }.to change(HospitalSystem, :count).by(2)
    end

    it 'associates hospital with systems' do
      import_hospital_systems

      universal_system = hospital_in_universal_system.reload.hospital_system
      resources_system = hospita_in_resources_system.reload.hospital_system

      expect(universal_system.name).to eq(universal_system_name)
      expect(resources_system.name).to eq(resources_system_name)
    end

    it 'leaves the hospital without system if it is not provided' do
      import_hospital_systems

      expect(hospital_without_system.reload.hospital_system).to be_nil
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
        hospitals: [hospita_in_resources_system],
      )
    end

    let!(:healthcare_system) do
      create(
        :hospital_system,
        name: 'Healthcare System',
        hospitals: [hospital_without_system],
      )
    end

    it 'does not create new systems' do
      expect { import_hospital_systems }.not_to change { HospitalSystem.count }
    end

    it 'associates hospital with systems' do
      import_hospital_systems

      universal_system = hospital_in_universal_system.reload.hospital_system
      resources_system = hospita_in_resources_system.reload.hospital_system

      expect(universal_system.name).to eq(universal_system_name)
      expect(resources_system.name).to eq(resources_system_name)
    end

    it 'leaves the hospital without system if it is not provided' do
      import_hospital_systems

      expect(hospital_without_system.reload.hospital_system).to be_nil
    end

    it 'removes hospitals from the system not included in the file' do
      import_hospital_systems

      expect(healthcare_system.reload.hospitals).to be_empty
    end
  end
end
