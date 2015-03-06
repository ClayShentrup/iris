require './app/models/hospital'
require './app/models/hospital_system'

module Hospitals
  # Encapsulates the information needed to show the options to compare one
  # hospital against others in the same city, state, system or across
  # the country
  class HospitalComparePresenter
    attr_reader :hospital
    delegate :name,
             :city_and_state,
             :state,
             to: :hospital,
             prefix: true

    delegate :hospital_system_name, to: :hospital

    def initialize(hospital)
      @hospital = hospital
    end

    def hospitals_in_city_count
      Hospital.in_same_city(hospital).count
    end

    def hospitals_in_state_count
      Hospital.in_same_state(hospital).count
    end

    def hospital_system?
      hospital_system.present?
    end

    def hospitals_in_system_count
      hospital_system.hospitals_count
    end

    def hospitals_count
      Hospital.count
    end

    private

    def hospital_system
      hospital.hospital_system
    end
  end
end
