require 'active_record_spec_helper'

require './app/models/hospital'
require './app/models/hospital_system'

require 'hospital_systems/importer'

RSpec.describe HospitalSystems::Importer do
  let(:file_path) { './spec/fixtures/hospital_systems_importer/test_file.xls' }

  let!(:hospital_in_system_1) do
    create(:hospital, :without_hospital_system, provider_id: '200001')
  end

  let!(:hospital_in_system_2) do
    create(:hospital, :without_hospital_system, provider_id: '200002')
  end

  let!(:hospital_without_system) do
    create(:hospital, :without_hospital_system, provider_id: '200003')
  end

  def import_hospital_systems
    described_class.call(file_path)
  end

  context 'no hospital systems were loaded before' do
    it 'creates new systems' do
      expect { import_hospital_systems }.to change(HospitalSystem, :count).by(2)
    end

    it 'associates hospital with systems' do
      import_hospital_systems

      hospital_system_1 = hospital_in_system_1.reload.hospital_system
      hospital_system_2 = hospital_in_system_2.reload.hospital_system

      expect(hospital_system_1.name).to eq('Hospital System 1')
      expect(hospital_system_2.name).to eq('Hospital System 2')
    end

    it 'leaves the hospital without system if it is not provided' do
      import_hospital_systems

      expect(hospital_without_system.reload.hospital_system).to be_nil
    end
  end

  context 'with hospital systems already created' do
    let!(:hospital_system_1) do
      create(:hospital_system, name: 'Hospital System 1')
    end

    let!(:hospital_system_2) do
      create(
        :hospital_system,
        name: 'Hospital System 2',
        hospitals: [hospital_in_system_2],
      )
    end

    let!(:hospital_system_3) do
      create(
        :hospital_system,
        name: 'Hospital System 3',
        hospitals: [hospital_without_system],
      )
    end

    it 'does not create new systems' do
      expect { import_hospital_systems }.not_to change { HospitalSystem.count }
    end

    it 'associates hospital with systems' do
      import_hospital_systems

      hospital_system_1 = hospital_in_system_1.reload.hospital_system
      hospital_system_2 = hospital_in_system_2.reload.hospital_system

      expect(hospital_system_1.name).to eq('Hospital System 1')
      expect(hospital_system_2.name).to eq('Hospital System 2')
    end

    it 'leaves the hospital without system if it is not provided' do
      import_hospital_systems

      expect(hospital_without_system.reload.hospital_system).to be_nil
    end

    it 'removes hospitals from the system not included in the file' do
      import_hospital_systems

      expect(hospital_system_3.reload.hospitals).to be_empty
    end
  end
end
